close all;
load('8.mat');
T(T == 0) = 10; % число 0 = класс 10
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.5, 0.5, 0);

Tvec = class2vec(T');
net = init_ff(P, Tvec, 100, 9);
net = train(net, P(trainIdx,:)', class2vec(T(trainIdx)));
Yvec = sim(net, P(testIdx,:)');
Y = vec2class(Yvec);
Q = calc_error(Y, T(testIdx))
perform(net, Y, T(testIdx))
plot_confusion(T(testIdx), Y);

function Q = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    Q = zeros(1, N);
    Tvec = class2vec(T)
    for i = 1 : N
        net = init_ff(P, Tvec, i, 9);
        net = train(net, P(trainIdx,:)', Tvec(:,trainIdx));
        Yvec = sim(net, P(testIdx,:)');
        Y = vec2class(Yvec);
        Q(i) = calc_error(Y, T(testIdx));
    end
end

% Функция обучения: 
%1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
%6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
%11-trainbfg, 12-trainoss, 13-trainbr
function net = init_ff(P, Tvec, N, trainFcn)
    net = newcf(P, Tvec, N);
    net.inputs{1}.size = 64;
    net.layers{2}.size = 10;
    net.layers{2}.transferFcn = 'purelin';
    net.performFcn = 'sse';
    net = init(net);
    net = set_train_param(net, trainFcn);
end

function plot_quality(X, Q)
    figure;
    grid on;
    plot(X, Q, 'linewidth', 2);
    xlabel('spread');
    ylabel('peform');
end

function plot_confusion(T, Y)
    figure;
    Tvec = class2vec(T);
    Yvec = class2vec(Y);
    plotconfusion(Tvec, Yvec);
end