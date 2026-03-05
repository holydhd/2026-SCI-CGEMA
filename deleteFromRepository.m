% Function that deletes extra particles from the repository based on crowding distances
function REP = deleteFromRepository(REP, n_extra, ngrid)
    % Calculate the crowding distances for the current repository
    crowding = zeros(size(REP.pos, 1), 1);
    for m = 1:size(REP.pos_fit, 2)
        % Sort repository based on fitness in the current objective
        [sorted_fit, idx] = sort(REP.pos_fit(:, m), 'ascend');
        
        % Compute distances between neighbors in the sorted list
        m_up = [sorted_fit(2:end); Inf];
        m_down = [Inf; sorted_fit(1:end-1)];
        distance = (m_up - m_down) ./ (max(sorted_fit) - min(sorted_fit));
        distance(isnan(distance)) = 0; % Handle division by zero
        
        % Accumulate crowding distances
        [~, unsorted_idx] = sort(idx, 'ascend');
        crowding = crowding + distance(unsorted_idx);
    end
    
    % Particles with higher crowding distances are preferred
    [~, del_idx] = sort(crowding, 'ascend');
    del_idx = del_idx(1:n_extra); % Select indices of particles to remove
    
    % Remove extra particles
    REP.pos(del_idx, :) = [];
    REP.pos_fit(del_idx, :) = [];
    
    % Update the repository grid
    REP = updateGrid(REP, ngrid);
end
