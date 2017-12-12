close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

plot_train_and_test(P, T, trainIdx, testIdx);

net = init_ff(P, T, 20);
net = trainlm(net, P(trainIdx), T(trainIdx));

[Y, Q] = range_hidden_neurons(50, P, T, trainIdx, testIdx);

plot_quality(Q);
plot_best_and_worst(P, T, Y);

function [Y, Q] = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    Q = zeros(1, N);
    Y = zeros(N, length(P));
    for i = 1 : N
        net = init_ff(P, T, i);
        net = trainlm(net, P(trainIdx), T(trainIdx));
        y = sim(net, P(testIdx));
        Y(i,:) = sim(net, P);
        Q(i) = perform(net, T(testIdx), y);
    end
end

function net = init_ff(P, T, N)
    net = newff(P, T, N);
    net = init(net);
    net.trainParam.epochs = 1000;
    net.trainParam.time = Inf;
    net.trainParam.goal = 0;
    net.trainParam.min_grad = 1e-05;
    net.trainParam.max_fail = 6;
end

function plot_train_and_test(P, T, trainIdx, testIdx)
    figure;
    hold on;
    grid on;
    plot(P(trainIdx), T(trainIdx), 'rx', 'linewidth', 2);
    plot(P(testIdx), T(testIdx), 'bo', 'linewidth', 2);
    legend('train', 'test');
    xlabel('x'); 
    ylabel('y');
end

function plot_quality(Q)
    figure;
    hold on;
    grid on;
    plot(1:length(Q), Q, 'linewidth', 2)
    xlabel('neurons'); 
    ylabel('perform');
end

function plot_best_and_worst(P, T, Y)
    figure;
    hold on;
    grid on;
    plot(P, Y(2,:), 'linewidth', 2);
    plot(P, Y(20,:), 'linewidth', 2);
    plot(P, Y(50,:), 'linewidth', 2);
    plot(P, T, 'linewidth', 2);
    legend('N=2', 'N=20', 'N=50', 'target');
    xlabel('x'); 
    ylabel('y');
end