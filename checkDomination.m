function dom_vector = checkDomination(fitness)
    Np = size(fitness, 1);
    dom_vector = zeros(Np, 1); % 默认所有个体未被支配
    all_perm = nchoosek(1:Np, 2); % 所有可能的个体对组合
    all_perm = [all_perm; [all_perm(:,2) all_perm(:,1)]]; % 双向比较
    
    % 检查支配关系
    d = dominates(fitness(all_perm(:,1), :), fitness(all_perm(:,2), :));
    dominated_particles = unique(all_perm(d == 1, 2)); % 被支配的个体索引
    dom_vector(dominated_particles) = 1; % 标记被支配的个体
end