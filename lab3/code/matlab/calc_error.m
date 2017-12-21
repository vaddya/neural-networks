function e_mean = calc_error(Y, T)
    e_mean = sum(sum(Y ~= T)) / length(T);
end