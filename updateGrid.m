% Function that updates the hypercube grid, the hypercube where each particle belongs,
% and calculates the quality based on the number of particles in each hypercube
function REP = updateGrid(REP, ngrid)
    % Get the number of dimensions (objectives)
    ndim = size(REP.pos_fit, 2);
    
    % Initialize the hypercube limits
    REP.hypercube_limits = zeros(ngrid + 1, ndim);
    for dim = 1:ndim
        REP.hypercube_limits(:, dim) = linspace(min(REP.pos_fit(:, dim)), max(REP.pos_fit(:, dim)), ngrid + 1)';
    end
    
    % Determine which hypercube each particle belongs to
    npar = size(REP.pos_fit, 1);
    REP.grid_idx = zeros(npar, 1); % Stores the hypercube ID for each particle
    REP.grid_subidx = zeros(npar, ndim); % Subindex for each dimension
    
    for n = 1:npar
        idnames = [];
        for d = 1:ndim
            % Find the hypercube index for the current dimension
            REP.grid_subidx(n, d) = find(REP.pos_fit(n, d) <= REP.hypercube_limits(:, d)', 1, 'first') - 1;
            if REP.grid_subidx(n, d) == 0
                REP.grid_subidx(n, d) = 1; % Ensure the index is within bounds
            end
            idnames = [idnames ',' num2str(REP.grid_subidx(n, d))]; %#ok<AGROW>
        end
        % Compute the global hypercube ID
        REP.grid_idx(n) = eval(['sub2ind(ngrid .* ones(1, ndim)' idnames ');']);
    end
    
    % Calculate quality based on the number of particles in each hypercube
    REP.quality = zeros(ngrid, 2); % Columns: [hypercube ID, quality]
    ids = unique(REP.grid_idx);
    for i = 1:length(ids)
        REP.quality(i, 1) = ids(i); % Hypercube ID
        REP.quality(i, 2) = 10 / sum(REP.grid_idx == ids(i)); % Quality is inversely proportional to density
    end
end
