% Function that updates the repository with a new population and fitness
% function REP = updateRepository(REP, POS, POS_fit, ngrid)
%     % Check domination for the current population
%     DOMINATED = checkDomination(POS_fit);
%     % 优先保留稀疏区域的解
% REP.quality(:,2) = REP.quality(:,2) .* (1 ./ crowding_distance(REP.pos_fit)); % 反比例调整质量
% 
%     % Add non-dominated solutions to the repository
%     REP.pos = [REP.pos; POS(~DOMINATED, :)];
%     REP.pos_fit = [REP.pos_fit; POS_fit(~DOMINATED, :)];
%     
%     % Check domination within the updated repository
%     DOMINATED = checkDomination(REP.pos_fit);
%     REP.pos_fit = REP.pos_fit(~DOMINATED, :);
%     REP.pos = REP.pos(~DOMINATED, :);
%     
%     % Update the hypercube grid for the repository
%     REP = updateGrid(REP, ngrid);
% end
function REP = updateRepository(REP, POS, POS_fit, ngrid)
    % 更新存档
    DOMINATED = checkDomination(POS_fit);
    REP.pos = [REP.pos; POS(~DOMINATED, :)];
    REP.pos_fit = [REP.pos_fit; POS_fit(~DOMINATED, :)];

    % 检查存档内的支配关系
    DOMINATED = checkDomination(REP.pos_fit);
    REP.pos_fit = REP.pos_fit(~DOMINATED, :);
    REP.pos = REP.pos(~DOMINATED, :);

    % 更新网格
    REP = updateGrid(REP, ngrid);

    % 计算拥挤距离并更新质量
    crowding = crowding_distance(REP.pos_fit);
    REP.quality = [REP.grid_idx crowding];
end
