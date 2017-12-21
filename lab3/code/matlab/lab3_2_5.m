close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

trainFcn = 5;    % Функция обучения: 
%1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
%6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
%11-trainbfg, 12-trainoss, 13-trainbr

Q = range_hidden_neurons(50, P, T, trainIdx, testIdx, trainFcn);
plot_quality(Q);

function plot_quality(Q)
    figure;
    hold on;
    grid on;
    plot(1:length(Q), Q, 'linewidth', 2)
    xlabel('neurons'); 
    ylabel('perform');
end

function Q = range_hidden_neurons(N, P, T, trainIdx, testIdx, trainFcn)
    Q = zeros(1, N);
    for i = 1 : N
        net = init_ff(P, T, i, trainFcn);
        net = trainlm(net, P(trainIdx), T(trainIdx));
        Y = sim(net, P(testIdx));
        Q(i) = perform(net, T(testIdx), Y);
    end
end

function net = init_ff(P, T, N, trainFcn)
    net = newff(P, T, N);
    net = init(net);
    net = set_train_param(net, trainFcn);
end