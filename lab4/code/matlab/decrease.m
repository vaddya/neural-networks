function [P, T, idx] = decrease(P, T, ratio)
    [idx, ~, ~] = dividerand(length(P), ratio, 1-ratio, 0);
    P = P(idx,:);
    T = T(idx);
end