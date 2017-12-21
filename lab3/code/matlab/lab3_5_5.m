close all;
load('8.mat');
load('8_noisy.mat');
load('8_rotate.mat');
load('8_shift.mat');
T(T == 0) = 10; % число 0 = класс 10
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.5, 0.5, 0);

Tvec = class2vec(T');
net = init_ff(P, Tvec, 50, 10);
net = train(net, P(trainIdx,:)', class2vec(T(trainIdx)));
Yvec = sim(net, P(testIdx,:)');
Y = vec2class(Yvec);
Q = calc_error(Y, T(testIdx))
plot_confusion(T(testIdx), Y);

research(net, P, T)
research(net, P_noisy, T)
research(net, P_rotate, T)
research(net, P_shift, T)

% Функция обучения: 
%1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
%6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
%11-trainbfg, 12-trainoss, 13-trainbr
function net = init_ff(P, Tvec, N, trainFcn)
    net = newff(P, Tvec, N);
    net.inputs{1}.size = 64;
    net.layers{2}.size = 10;
    net = init(net);
    net = set_train_param(net, trainFcn);
end

function Q = research(net, P, T)
    Yvec = sim(net, P');
    Y = vec2class(Yvec);
    Q = calc_error(Y, T);
    plot_confusion(T', Y);
end

function plot_confusion(T, Y)
    figure;
    Tvec = class2vec(T);
    Yvec = class2vec(Y);
    plotconfusion(Tvec, Yvec);
end