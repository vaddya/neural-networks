close all;
load('3.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

plot_train_and_test(P, T, trainIdx, testIdx);

Q_all = zeros(4, 50);
[~, Q_all(4,:)] = range_hidden_neurons(50, P, T, trainIdx, testIdx);

plot_quality(Q_all);

net = init_ff(P, T, 10);s
net = train(net, P(trainIdx,:)', T(trainIdx)');
Y = sim(net, P(testIdx,:)') > 0.5;
err = perform(net, T(testIdx)', Y)

plot_classes(P, sim(net, P') > 0.5);

function [Y, Q] = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    Q = zeros(1, N);
    Y = zeros(N, length(P));
    for i = 1 : N
        net = init_ff(P, T, i);
        net = train(net, P(trainIdx,:)', T(trainIdx)');
        y = sim(net, P(testIdx,:)') > 0.5;
        Y(i,:) = sim(net, P') > 0.5;
        Q(i) = perform(net, T(testIdx)', y);
    end
end

function net = init_ff(P, T, N)
    net = newff(P, T, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 1;
    net = init(net);
    type_train_func = 6;    % Функция обучения: 
    %1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
    %6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
    %11-trainbfg, 12-trainoss, 13-trainbr

    set_train_param(net, type_train_func);
end

function plot_train_and_test(P, T, trainIdx, testIdx)
    figure;
    hold on;
    grid on;
    gscatter(P(trainIdx,1), P(trainIdx,2), T(trainIdx), 'br', 'oo');
    gscatter(P(testIdx,1), P(testIdx,2), T(testIdx), 'br', 'xx');
    legend('train 0', 'train 1', 'test 0', 'test 1');
    xlabel('x1'); 
    ylabel('x2');
    axis([0 1 0 1]);
end

function plot_classes(P, Y)
    figure;
    hold on;
    grid on;
    gscatter(P(:,1), P(:,2), Y, 'br', 'ox');
    xlabel('x1'); 
    ylabel('x2');
    axis([0 1 0 1]);
end

function plot_quality(Q_all)
    figure;
    hold on;
    grid on;
    for i = 1 : size(Q_all, 1)
        plot(1:length(Q_all(i,:)), Q_all(i,:), 'linewidth', 2);
    end
    legend('trainlm', 'trainbfg', 'traingdx', 'traincgf');
    xlabel('neurons'); 
    ylabel('perform');
end