close all;
load('8.mat');
load('8_noisy.mat');
load('8_rotate.mat');
load('8_shift.mat');
T = double(T);

Tvec = class2vec(T' + 1);
net = newpnn(P', Tvec, 10);
Yvec = sim(net, P');
Y = vec2class(Yvec) - 1;
Q = perform(net, T, Y)
plot_confusion(T', Y);

Q_noisy = research(net, P_noisy, T)
Q_rotate = research(net, P_rotate, T)
Q_shift = research(net, P_shift, T)

function Q = research(net, P, T)
    Yvec = sim(net, P');
    Y = vec2class(Yvec) - 1;
    Q = perform(net, T, Y);
    plot_confusion(T', Y);
end

function plot_confusion(T, Y)
    figure;
    Tvec = class2vec(T');
    Yvec = class2vec(Y);
    plotconfusion(Tvec, Yvec);
end