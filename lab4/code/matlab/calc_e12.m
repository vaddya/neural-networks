function [e1, e2] = calc_e12(Y, T)
    c = confusionmat(T', Y');
    c1 = c - diag(diag(c));
    e1 = sum(c1) ./ sum(c);
    e2 = sum(c1') ./ sum(c');
end