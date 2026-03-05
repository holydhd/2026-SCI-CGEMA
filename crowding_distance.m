% function distance = crowding_distance(fitness)
%     % Calculate the crowding distance for a given set of fitness values
%     [Np, nObj] = size(fitness); % Np: number of particles, nObj: number of objectives
%     distance = zeros(Np, 1); % Initialize the crowding distance vector
% 
%     % For each objective, compute the crowding distance
%     for m = 1:nObj
%         % Sort the fitness values for the current objective
%         [sorted_fitness, sorted_idx] = sort(fitness(:, m), 'ascend');
%         
%         % Assign infinite distance to boundary solutions
%         distance(sorted_idx(1)) = Inf;
%         distance(sorted_idx(end)) = Inf;
% 
%         % Compute distances for intermediate solutions
%         for i = 2:(Np - 1)
%             distance(sorted_idx(i)) = distance(sorted_idx(i)) + ...
%                 (sorted_fitness(i + 1) - sorted_fitness(i - 1)) / ...
%                 (max(fitness(:, m)) - min(fitness(:, m)) + 1e-6); % Avoid division by zero
%         end
%     end
% end
function distance = crowding_distance(fitness)
    [Np, nObj] = size(fitness); % Np: 粒子数, nObj: 目标数
    distance = zeros(Np, 1); % 初始化拥挤距离向量

    for m = 1:nObj
        % 对每个目标函数进行排序
        [sorted_fitness, sorted_idx] = sort(fitness(:, m), 'ascend');
        
        % 为边界解分配无穷距离
        distance(sorted_idx(1)) = Inf;
        distance(sorted_idx(end)) = Inf;

        % 对中间解计算距离
        for i = 2:(Np - 1)
            if max(fitness(:, m)) - min(fitness(:, m)) > 1e-6 % 避免除以 0
                distance(sorted_idx(i)) = distance(sorted_idx(i)) + ...
                    (sorted_fitness(i + 1) - sorted_fitness(i - 1)) / ...
                    (max(fitness(:, m)) - min(fitness(:, m)) + 1e-6);
            else
                % 如果目标值范围过小，则分配一个小距离
                distance(sorted_idx(i)) = distance(sorted_idx(i)) + 1e-3;
            end
        end
    end
end
