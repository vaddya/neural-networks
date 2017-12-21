close all;
load('8.mat');
load('8_noisy.mat');
load('8_rotate.mat');
load('8_shift.mat');
T(T == 0) = 10; % число 0 = класс 10
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.5, 0.5, 0);

Tvec = class2vec(T(trainIdx)');
net = newpnn(P(trainIdx,:)', Tvec, 10);

[Q, e1, e2] = research(net, P, T)
[Q_noisy, e1_noisy, e2_noisy] = research(net, P_noisy, T)
[Q_rotate, e1_rotate, e2_rotate] = research(net, P_rotate, T)
[Q_shift, e1_shift, e2_shift] = research(net, P_shift, T)

function [Q, e1, e2] = research(net, P, T)
    Yvec = sim(net, P');
    Y = vec2class(Yvec);
    Q = calc_error(Y, T);
    [e1, e2] = calc_e12(Y, T);
    plot_confusion(T, Y);
end

function plot_confusion(T, Y)
    figure;
    Tvec = class2vec(T');
    Yvec = class2vec(Y);
    plotconfusion(Tvec, Yvec);
end