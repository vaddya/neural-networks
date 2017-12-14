P = 0.01 : 0.01 : 1;

[Ptr, Pval, Ptest] = divideblock(P, 0.5, 0.3, 0.2);

[Ptr, Pval, Ptest] = divideind(P, 1:50, 51:80, 81:100);

[Ptr, Pval, Ptest] = divideint(P, 0.5, 0.3, 0.2);

[Ptr, Pval, Ptest] = dividerand(P, 0.5, 0.3, 0.2);

[Ptr, Pval, Ptest] = dividetrain(P, 0.5, 0.3, 0.2);