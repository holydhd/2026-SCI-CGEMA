function [ weights,bestvalue,best333index, relative_closeness] = entropy_topsis_zuixin(pareto_solutions)
    % 输入：pareto_solutions - 多目标遗传算法得到的Pareto解矩阵，每一行代表一个解，
    % 后三列分别为效益型目标和两个成本型目标的值

    % 步骤1: 数据标准化
    % 提取目标值
    objective_values = pareto_solutions(:, end - 2:end);
    num_solutions = size(objective_values, 1);
    num_objectives = size(objective_values, 2);

    % 标准化矩阵
    standardized_values = zeros(num_solutions, num_objectives);
    % 效益型目标（第一个输出）
    standardized_values(:, 1) = (objective_values(:, 1) - min(objective_values(:, 1))) / ...
        (max(objective_values(:, 1)) - min(objective_values(:, 1)));
    % 成本型目标（第二个输出）
    standardized_values(:, 2) = (max(objective_values(:, 2)) - objective_values(:, 2)) / ...
        (max(objective_values(:, 2)) - min(objective_values(:, 2)));
    % 成本型目标（第三个输出）
    standardized_values(:, 3) = (max(objective_values(:, 3)) - objective_values(:, 3)) / ...
        (max(objective_values(:, 3)) - min(objective_values(:, 3)));

    % 步骤2: 熵权法计算权重
    % 计算比重
    proportion = zeros(num_solutions, num_objectives);
    for j = 1:num_objectives
        proportion(:, j) = standardized_values(:, j) / sum(standardized_values(:, j));
    end

    % 计算熵值
    entropy = zeros(1, num_objectives);
    for j = 1:num_objectives
        entropy(j) = -1 / log(num_solutions) * sum(proportion(:, j) .* log(proportion(:, j) + eps));
    end

    % 计算差异系数
    difference_coefficient = 1 - entropy;

    % 计算权重
    weights = difference_coefficient / sum(difference_coefficient);

    % 步骤3: 构建加权标准化矩阵
    weighted_standardized_values = standardized_values .* repmat(weights, num_solutions, 1);

    % 步骤4: 确定正理想解和负理想解
    positive_ideal_solution = max(weighted_standardized_values);
    negative_ideal_solution = min(weighted_standardized_values);

    % 步骤5: 计算各方案到理想解的距离
    distance_to_positive = sqrt(sum((weighted_standardized_values - repmat(positive_ideal_solution, num_solutions, 1)).^2, 2));
    distance_to_negative = sqrt(sum((weighted_standardized_values - repmat(negative_ideal_solution, num_solutions, 1)).^2, 2));

    % 步骤6: 计算相对接近度
    relative_closeness = distance_to_negative ./ (distance_to_positive + distance_to_negative);
    % 步骤7: 筛选出最优解
    [~, best_solution_index] = max(relative_closeness);
    [bestvalue,best333index]=sort(relative_closeness,'descend');


end
