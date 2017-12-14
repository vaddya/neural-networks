close all;
load('3.mat');
T = double(T);

net = init_ff(P, T, 20);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

%plot_train_and_test(P, T, trainIdx, testIdx);

%[Y, Q] = range_hidden_neurons(50, P, T, trainIdx, testIdx);

%plot_quality(Q);

plot_classes(P, Y(20,:));

function [Y, Q] = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    Q = zeros(1, N);
    Y = zeros(N, length(P));
    for i = 1 : N
        net = init_ff(P, T, i);
        net = train(net, P(trainIdx,:)', T(trainIdx)');
        y = sim(net, P(testIdx,:)') > 0;
        Y(i,:) = sim(net, P') > 0;
        Q(i) = perform(net, T(testIdx)', y);
    end
end

function net = init_ff(P, T, N)
    net = newff(P, T, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 1;
    net = init(net);
    net.trainParam.epochs = 1000;
    net.trainParam.time = Inf;
    net.trainParam.goal = 0;
    net.trainParam.min_grad = 1e-05;
    net.trainParam.max_fail = 15;
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

function plot_quality(Q)
    figure;
    hold on;
    grid on;
    plot(1:length(Q), Q, 'linewidth', 2)
    xlabel('neurons'); 
    ylabel('perform');
end