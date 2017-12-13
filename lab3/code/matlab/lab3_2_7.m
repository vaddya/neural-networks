close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

%[Y, Q] = range_hidden_neurons(30, P, T, trainIdx, testIdx);

%plot_quality(Q);

plot_best_and_worst(P, T, Y);

function [Y, Q] = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    Q = zeros(N, N);
    Y = zeros(N, N, length(P));
    for i = 1 : N
        for j = 1 : N
            net = init_ff(P, T, [i, j]);
            net = trainlm(net, P(trainIdx), T(trainIdx));
            y = sim(net, P(testIdx));
            Y(i,j,:) = sim(net, P);
            Q(i,j) = perform(net, T(testIdx), y);
        end
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

function plot_quality(Q)
    figure;
    grid on;
    surf(Q);
    xlabel('neurons 1'); 
    ylabel('neurons 2'); 
    zlabel('perform');
end

function plot_best_and_worst(P, T, Y)
    figure;
    hold on;
    grid on;
    plot(P, reshape(Y(9,9,:), 1, []), 'linewidth', 2);
    plot(P, reshape(Y(3,25,:), 1, []), 'linewidth', 2);
    plot(P, T, 'linewidth', 2);
    legend('N=[9,9]', 'N=[3,25]', 'target');
    xlabel('x'); 
    ylabel('y');
end