% Function that returns 1 if x dominates y and 0 otherwise
function d = dominates(x, y)
    % x 支配 y 的条件：x 的所有目标值都小于等于 y，并且至少一个目标值严格小于 y
    d = all(x <= y, 2) & any(x < y, 2);
end
