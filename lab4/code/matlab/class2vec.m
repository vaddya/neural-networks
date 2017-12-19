function Tvec = class2vec(T)
    C = max(T);
    Tvec = zeros(C, length(T));

    for i = 1 : C
        Tvec(i,:) = (T == i);
    end
end

