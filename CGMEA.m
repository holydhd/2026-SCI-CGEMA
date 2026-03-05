function REP = CGMEA(params, MultiObj)
% CGMEA: Constraint Grouping Multi-population Evolutionary Algorithm (CMOP/CMOEA)
% Core idea:
%   - Constraint grouping: partition constraints into groups (or single constraints)
%   - Multi-population: one main population + auxiliary populations, each focuses on one group
%   - Competition & cooperation: auxiliary populations push feasibility; main population pushes PF
%
% NOTE:
%   - MultiObj.fun(x)  -> 1×M objective row (minimization)
%   - MultiObj.cons(x) -> 1×K constraint row, feasible if <=0
%   - Optional: MultiObj.repair(X) -> analytic repair for special constraints (matrix in, matrix out)

% Parameters
Np      = params.Np;      % Population size (for each population)
Nr      = params.Nr;      % Repository size
maxgen  = params.maxgen;  % Maximum number of generations
ngrid   = 30;             % Grid divisions for repository
fun     = MultiObj.fun;   % Objective functions
nVar    = MultiObj.nVar;  % Number of decision variables
var_min = MultiObj.var_min(:); % Lower bounds
var_max = MultiObj.var_max(:); % Upper bounds

% Constraint function (required)
if isfield(MultiObj,'cons') && isa(MultiObj.cons,'function_handle')
    cons = MultiObj.cons;
else
    error('MultiObj.cons is required for constrained MOP. Define MultiObj.cons(x) returning g<=0 feasible.');
end

% Optional analytic repair (recommended for constraints like b<d, e<6.5, etc.)
useRepair = (isfield(MultiObj,'repair') && isa(MultiObj.repair,'function_handle'));
if useRepair
    repair = MultiObj.repair;
end

% Grouping / competition parameters (defaults)
if isfield(params,'groupSize');     groupSize     = params.groupSize;     else; groupSize = 1; end
if isfield(params,'corrTh');        corrTh        = params.corrTh;        else; corrTh = 0.7; end
if isfield(params,'exchangeFrac');  exchangeFrac  = params.exchangeFrac;  else; exchangeFrac = 0.10; end
if isfield(params,'auxExploreFrac');auxExploreFrac= params.auxExploreFrac;else; auxExploreFrac = 0.5; end

%% Initialization (Main population)
POS = repmat((var_max - var_min)', Np, 1) .* rand(Np, nVar) + repmat(var_min', Np, 1);
if useRepair
    POS = repair(POS);
end

% Evaluate initial population
for i = 1:Np
    POS_fit(i, :) = fun(POS(i, :));
    POS_con(i, :) = cons(POS(i, :));
end
POS_cvC = max(0, POS_con);              % per-constraint violation
POS_cv  = sum(POS_cvC, 2);              % total violation

PBEST = POS;                            % Personal best positions
PBEST_fit = POS_fit;                    % Personal best fitness
PBEST_cv  = POS_cv;                     % Personal best CV

% Determine #constraints and groups
K = size(POS_con, 2);
if isfield(MultiObj,'groups') && ~isempty(MultiObj.groups)
    GROUPS = MultiObj.groups;           % user-provided: cell array of index vectors
else
    GROUPS = groupConstraints(POS_cvC, groupSize, corrTh);
end
S = numel(GROUPS);                      % number of auxiliary populations

% Initialize main repository (constrained non-dominated)
DOMINATED = checkDominationCMOP(POS_fit, POS_cv);
REP.pos = POS(~DOMINATED, :);
REP.pos_fit = POS_fit(~DOMINATED, :);
REP.pos_cv  = POS_cv(~DOMINATED, :);
REP = updateGrid(REP, ngrid);

% Initialize auxiliary populations (each focuses on one constraint-group)
for s = 1:S
    SUB{s}.POS = repmat((var_max - var_min)', Np, 1) .* rand(Np, nVar) + repmat(var_min', Np, 1);
    if useRepair
        SUB{s}.POS = repair(SUB{s}.POS);
    end
    
    for i = 1:Np
        SUB{s}.FIT(i, :) = fun(SUB{s}.POS(i, :));
        SUB{s}.CON(i, :) = cons(SUB{s}.POS(i, :));
    end
    
    SUB{s}.CVC  = max(0, SUB{s}.CON);
    SUB{s}.CVG  = sum(SUB{s}.CVC(:, GROUPS{s}), 2);   % group CV (only this group)
    
    SUB{s}.PBEST     = SUB{s}.POS;
    SUB{s}.PBEST_fit = SUB{s}.FIT;
    SUB{s}.PBEST_cvg = SUB{s}.CVG;
    
    DOM_s = checkDominationCMOP(SUB{s}.FIT, SUB{s}.CVG);
    SUB{s}.REP.pos     = SUB{s}.POS(~DOM_s, :);
    SUB{s}.REP.pos_fit = SUB{s}.FIT(~DOM_s, :);
    SUB{s}.REP.pos_cv  = SUB{s}.CVG(~DOM_s, :);
    SUB{s}.REP = updateGrid(SUB{s}.REP, ngrid);
end

gen = 1;
display(['Generation #0 - Repository size: ' num2str(size(REP.pos, 1))]);
stopCondition = false;

while ~stopCondition
    
    %% =========================
    %  Auxiliary Populations (Constraint-group evolution)
    %  Each auxiliary population reduces CV for its constraint group.
    %% =========================
    for s = 1:S
        
        lengS = size(SUB{s}.REP.pos, 1);
        
        % -------- Phase A1: Exploration toward feasibility of group s --------
        for i = 1:Np
            
            if lengS > 0 && rand < auxExploreFrac
                selected = SUB{s}.REP.pos(randi(lengS), :);
            else
                % Prefer lower group CV individuals
                better = find(SUB{s}.CVG < SUB{s}.CVG(i));
                if isempty(better)
                    selected = SUB{s}.POS(randi(Np), :);
                else
                    selected = SUB{s}.POS(better(randi(length(better))), :);
                end
            end
            
            exploration_factor = rand * 0.5;
            SUB{s}.POS(i, :) = selected + exploration_factor * (selected - SUB{s}.PBEST(i, :)) + ...
                rand(1, nVar) .* (var_min' + rand(1, nVar) .* (var_max' - var_min') - SUB{s}.POS(i, :));
            
            SUB{s}.POS(i, :) = max(SUB{s}.POS(i, :), var_min');
            SUB{s}.POS(i, :) = min(SUB{s}.POS(i, :), var_max');
            if useRepair
                SUB{s}.POS(i, :) = repair(SUB{s}.POS(i, :));
            end
            
            SUB{s}.FIT(i, :) = fun(SUB{s}.POS(i, :));
            SUB{s}.CON(i, :) = cons(SUB{s}.POS(i, :));
            SUB{s}.CVC(i, :) = max(0, SUB{s}.CON(i, :));
            SUB{s}.CVG(i, 1) = sum(SUB{s}.CVC(i, GROUPS{s}));
        end
        
        SUB{s}.REP = updateRepositoryCMOP(SUB{s}.REP, SUB{s}.POS, SUB{s}.FIT, SUB{s}.CVG, ngrid);
        if size(SUB{s}.REP.pos, 1) > Nr
            SUB{s}.REP = deleteFromRepository(SUB{s}.REP, size(SUB{s}.REP.pos, 1) - Nr, ngrid);
        end
        
        % -------- Phase A2: Exploitation (repair-guided pull toward good group-feasible points) --------
        for i = 1:Np
            
            if size(SUB{s}.REP.pos, 1) > 0
                guide = SUB{s}.REP.pos(randi(size(SUB{s}.REP.pos, 1)), :);
            else
                [~, bi] = min(SUB{s}.CVG);
                guide = SUB{s}.POS(bi, :);
            end
            
            cleaning_factor = 0.5 + 0.5 * (1 - gen / maxgen);
            SUB{s}.POS(i, :) = SUB{s}.PBEST(i, :) + cleaning_factor * (guide - SUB{s}.POS(i, :));
            
            SUB{s}.POS(i, :) = max(SUB{s}.POS(i, :), var_min');
            SUB{s}.POS(i, :) = min(SUB{s}.POS(i, :), var_max');
            if useRepair
                SUB{s}.POS(i, :) = repair(SUB{s}.POS(i, :));
            end
            
            SUB{s}.FIT(i, :) = fun(SUB{s}.POS(i, :));
            SUB{s}.CON(i, :) = cons(SUB{s}.POS(i, :));
            SUB{s}.CVC(i, :) = max(0, SUB{s}.CON(i, :));
            SUB{s}.CVG(i, 1) = sum(SUB{s}.CVC(i, GROUPS{s}));
        end
        
        SUB{s}.REP = updateRepositoryCMOP(SUB{s}.REP, SUB{s}.POS, SUB{s}.FIT, SUB{s}.CVG, ngrid);
        if size(SUB{s}.REP.pos, 1) > Nr
            SUB{s}.REP = deleteFromRepository(SUB{s}.REP, size(SUB{s}.REP.pos, 1) - Nr, ngrid);
        end
        
        % -------- Update auxiliary PBEST (Deb rules using group CV) --------
        for i = 1:Np
            if betterDeb(SUB{s}.FIT(i, :), SUB{s}.CVG(i), SUB{s}.PBEST_fit(i, :), SUB{s}.PBEST_cvg(i))
                SUB{s}.PBEST(i, :)     = SUB{s}.POS(i, :);
                SUB{s}.PBEST_fit(i, :) = SUB{s}.FIT(i, :);
                SUB{s}.PBEST_cvg(i, 1) = SUB{s}.CVG(i);
            elseif ~betterDeb(SUB{s}.PBEST_fit(i, :), SUB{s}.PBEST_cvg(i), SUB{s}.FIT(i, :), SUB{s}.CVG(i)) && rand < 0.5
                SUB{s}.PBEST(i, :)     = SUB{s}.POS(i, :);
                SUB{s}.PBEST_fit(i, :) = SUB{s}.FIT(i, :);
                SUB{s}.PBEST_cvg(i, 1) = SUB{s}.CVG(i);
            end
        end
        
    end
    
    %% =========================
    %  Competition & Cooperation (Aux -> Main, Main -> Aux)
    %% =========================
    nEx = max(1, round(exchangeFrac * Np));
    
    % ---- Aux -> Main: inject best group-feasible candidates into main ----
    for s = 1:S
        candX = pickBestByCV(SUB{s}.POS, SUB{s}.FIT, SUB{s}.CVG, nEx);
        worstIdx = pickWorstByCV(POS, POS_fit, POS_cv, nEx);
        POS(worstIdx, :) = candX;
        for k = 1:numel(worstIdx)
            i = worstIdx(k);
            POS_fit(i, :) = fun(POS(i, :));
            POS_con(i, :) = cons(POS(i, :));
        end
        POS_cvC = max(0, POS_con);
        POS_cv  = sum(POS_cvC, 2);
    end
    
    % ---- Main -> Aux: maintain diversity (send random main individuals) ----
    for s = 1:S
        sendIdx = randperm(Np, nEx);
        recvIdx = pickWorstByCV(SUB{s}.POS, SUB{s}.FIT, SUB{s}.CVG, nEx);
        SUB{s}.POS(recvIdx, :) = POS(sendIdx, :);
        for k = 1:numel(recvIdx)
            i = recvIdx(k);
            SUB{s}.FIT(i, :) = fun(SUB{s}.POS(i, :));
            SUB{s}.CON(i, :) = cons(SUB{s}.POS(i, :));
            SUB{s}.CVC(i, :) = max(0, SUB{s}.CON(i, :));
            SUB{s}.CVG(i, 1) = sum(SUB{s}.CVC(i, GROUPS{s}));
        end
        SUB{s}.REP = updateRepositoryCMOP(SUB{s}.REP, SUB{s}.POS, SUB{s}.FIT, SUB{s}.CVG, ngrid);
        if size(SUB{s}.REP.pos, 1) > Nr
            SUB{s}.REP = deleteFromRepository(SUB{s}.REP, size(SUB{s}.REP.pos, 1) - Nr, ngrid);
        end
    end
    
    %% =========================
    %  Main Population (Constrained multi-objective evolution)
    %% =========================
    leng = size(REP.pos, 1);
    
    % -------- Phase 1: Scouting and resource detection (Exploration) --------
    for i = 1:Np
        
        if leng > 0 && rand < 0.5
            selected_resource = REP.pos(randi(leng), :);
        else
            % Prefer lower CV; if equal, prefer better objectives (sum proxy)
            better = find(POS_cv < POS_cv(i));
            if isempty(better)
                better = find(sum(POS_fit, 2) < sum(POS_fit(i, :)));
            end
            if isempty(better)
                if leng > 0
                    selected_resource = REP.pos(randi(leng), :);
                else
                    selected_resource = POS(randi(Np), :);
                end
            else
                selected_resource = POS(better(randi(length(better))), :);
            end
        end
        
        exploration_factor = rand * 0.5;
        POS(i, :) = selected_resource + exploration_factor * (selected_resource - PBEST(i, :)) + ...
            rand(1, nVar) .* (var_min' + rand(1, nVar) .* (var_max' - var_min') - POS(i, :));
        
        POS(i, :) = max(POS(i, :), var_min');
        POS(i, :) = min(POS(i, :), var_max');
        if useRepair
            POS(i, :) = repair(POS(i, :));
        end
        
        POS_fit(i, :) = fun(POS(i, :));
        POS_con(i, :) = cons(POS(i, :));
        POS_cvC(i, :) = max(0, POS_con(i, :));
        POS_cv(i, 1)  = sum(POS_cvC(i, :));
    end
    
    % -------- Update main repository --------
    REP = updateRepositoryCMOP(REP, POS, POS_fit, POS_cv, ngrid);
    if size(REP.pos, 1) > Nr
        REP = deleteFromRepository(REP, size(REP.pos, 1) - Nr, ngrid);
    end
    
    % -------- Phase 2: Cleaning and optimizing (Exploitation) --------
    for i = 1:Np
        
        if size(REP.pos, 1) > 0
            clean_resource = REP.pos(randi(size(REP.pos, 1)), :);
        else
            [~, bi] = min(POS_cv);
            clean_resource = POS(bi, :);
        end
        
        cleaning_factor = 0.5 + 0.5 * (1 - gen / maxgen);
        POS(i, :) = PBEST(i, :) + cleaning_factor * (clean_resource - POS(i, :));
        
        POS(i, :) = max(POS(i, :), var_min');
        POS(i, :) = min(POS(i, :), var_max');
        if useRepair
            POS(i, :) = repair(POS(i, :));
        end
        
        POS_fit(i, :) = fun(POS(i, :));
        POS_con(i, :) = cons(POS(i, :));
        POS_cvC(i, :) = max(0, POS_con(i, :));
        POS_cv(i, 1)  = sum(POS_cvC(i, :));
    end
    
    % -------- Update main repository again --------
    REP = updateRepositoryCMOP(REP, POS, POS_fit, POS_cv, ngrid);
    if size(REP.pos, 1) > Nr
        REP = deleteFromRepository(REP, size(REP.pos, 1) - Nr, ngrid);
    end
    
    % -------- Update main PBEST (Deb rules with total CV) --------
    for i = 1:Np
        if betterDeb(POS_fit(i, :), POS_cv(i), PBEST_fit(i, :), PBEST_cv(i))
            PBEST(i, :)     = POS(i, :);
            PBEST_fit(i, :) = POS_fit(i, :);
            PBEST_cv(i, 1)  = POS_cv(i);
        elseif ~betterDeb(PBEST_fit(i, :), PBEST_cv(i), POS_fit(i, :), POS_cv(i)) && rand < 0.5
            PBEST(i, :)     = POS(i, :);
            PBEST_fit(i, :) = POS_fit(i, :);
            PBEST_cv(i, 1)  = POS_cv(i);
        end
    end
    
    %% Display progress
    nFeaPop = sum(POS_cv == 0);
    nFeaRep = 0;
    if isfield(REP,'pos_cv') && ~isempty(REP.pos_cv)
        nFeaRep = sum(REP.pos_cv == 0);
    end
    display(['Generation #' num2str(gen) ' - Repository size: ' num2str(size(REP.pos, 1)) ...
        ' - Feasible(pop/rep): ' num2str(nFeaPop) '/' num2str(nFeaRep) ...
        ' - Groups: ' num2str(S) ' (K=' num2str(K) ')']);
    
    % Check termination condition
    gen = gen + 1;
    if gen > maxgen
        stopCondition = true;
    end
end

end

%% ========================= Helper (Local) Functions =========================
function GROUPS = groupConstraints(CVC, groupSize, corrTh)
% Greedy grouping based on correlation of violation patterns.
% CVC: N×K nonnegative violation matrix (per constraint).
K = size(CVC,2);
if K == 0
    GROUPS = {[]};
    return;
end
if groupSize <= 1
    GROUPS = cell(1,K);
    for k = 1:K
        GROUPS{k} = k;
    end
    return;
end

C = corrcoef(CVC + 1e-12); % K×K
assigned = false(1,K);
GROUPS = {};

for k = 1:K
    if assigned(k), continue; end
    grp = k;
    assigned(k) = true;
    
    % add most correlated constraints
    [~, ord] = sort(C(k,:), 'descend');
    for j = ord
        if ~assigned(j) && C(k,j) >= corrTh
            grp = [grp, j]; %#ok<AGROW>
            assigned(j) = true;
            if numel(grp) >= groupSize
                break;
            end
        end
    end
    
    GROUPS{end+1} = grp; %#ok<AGROW>
end
end

function DOMINATED = checkDominationCMOP(F, CV)
% Constrained domination:
% A dominates B if:
% (1) CV_A < CV_B, or
% (2) both feasible (CV=0) and Pareto-dominates in objectives
N = size(F,1);
DOMINATED = false(N,1);
for i = 1:N
    for j = 1:N
        if i == j, continue; end
        if constrainedDominates(F(j,:), CV(j), F(i,:), CV(i))
            DOMINATED(i) = true;
            break;
        end
    end
end
end

function flag = constrainedDominates(Fa, CVa, Fb, CVb)
if CVa < CVb
    flag = true;
elseif CVa > CVb
    flag = false;
else
    if CVa == 0
        flag = dominates(Fa, Fb);
    else
        flag = false;
    end
end
end

function ok = betterDeb(Fa, CVa, Fb, CVb)
% Deb's feasibility rules:
% 1) feasible beats infeasible
% 2) among feasible, Pareto dominance
% 3) among infeasible, smaller CV is better
if CVa == 0 && CVb > 0
    ok = true;
elseif CVa > 0 && CVb == 0
    ok = false;
elseif CVa == 0 && CVb == 0
    ok = dominates(Fa, Fb);
else
    ok = (CVa < CVb);
end
end

function flag = dominates(a, b)
% Pareto dominance for minimization
flag = all(a <= b) && any(a < b);
end

function REP = updateRepositoryCMOP(REP, POS, POS_fit, POS_cv, ngrid)
% Merge and keep constrained non-dominated solutions
if ~isfield(REP,'pos') || isempty(REP.pos)
    X  = POS;
    F  = POS_fit;
    CV = POS_cv;
else
    X  = [REP.pos; POS];
    F  = [REP.pos_fit; POS_fit];
    CV = [REP.pos_cv; POS_cv];
end

DOMINATED = checkDominationCMOP(F, CV);

REP.pos     = X(~DOMINATED, :);
REP.pos_fit = F(~DOMINATED, :);
REP.pos_cv  = CV(~DOMINATED, :);

REP = updateGrid(REP, ngrid);
end

function REP = updateGrid(REP, ngrid)
% Simple grid in objective space for diversity maintenance
F = REP.pos_fit;
N = size(F,1);
M = size(F,2);

if N == 0
    REP.grid = [];
    return;
end

fmin = min(F, [], 1);
fmax = max(F, [], 1);
d = (fmax - fmin) ./ ngrid;
d(d == 0) = 1;

sub = zeros(N, M);
for m = 1:M
    sub(:,m) = floor((F(:,m) - fmin(m)) ./ d(m)) + 1;
    sub(:,m) = min(max(sub(:,m), 1), ngrid);
end

% linear index
ind = sub(:,1);
base = 1;
for m = 2:M
    base = base * ngrid;
    ind = ind + (sub(:,m)-1) * base;
end

REP.grid.ngrid = ngrid;
REP.grid.fmin  = fmin;
REP.grid.fmax  = fmax;
REP.grid.sub   = sub;
REP.grid.ind   = ind;
end

function REP = deleteFromRepository(REP, nDelete, ngrid)
% Delete solutions from most crowded grid cells (grid-based truncation)
if nDelete <= 0 || ~isfield(REP,'pos') || isempty(REP.pos)
    return;
end

% Ensure grid exists
if ~isfield(REP,'grid') || isempty(REP.grid) || ~isfield(REP.grid,'ind')
    REP = updateGrid(REP, ngrid);
end

for k = 1:nDelete
    ind = REP.grid.ind;
    if isempty(ind), break; end
    
    % cell densities
    [u, ~, ic] = unique(ind);
    cnt = accumarray(ic, 1);
    [~, mx] = max(cnt);
    densestCell = u(mx);
    
    idxCell = find(ind == densestCell);
    rem = idxCell(randi(numel(idxCell)));
    
    REP.pos(rem,:) = [];
    REP.pos_fit(rem,:) = [];
    if isfield(REP,'pos_cv') && ~isempty(REP.pos_cv)
        REP.pos_cv(rem,:) = [];
    end
    
    REP = updateGrid(REP, ngrid);
end
end

function Xbest = pickBestByCV(POS, FIT, CV, nPick)
% Select best individuals: smaller CV first; if tie, smaller sum objectives
nPick = min(nPick, size(POS,1));
score = [CV, sum(FIT,2)];
[~, ord] = sortrows(score, [1 2]);
Xbest = POS(ord(1:nPick), :);
end

function idx = pickWorstByCV(POS, FIT, CV, nPick)
% Select worst individuals: larger CV first; if tie, larger sum objectives
nPick = min(nPick, size(POS,1));
score = [CV, sum(FIT,2)];
[~, ord] = sortrows(score, [-1 -2]);
idx = ord(1:nPick);
end
