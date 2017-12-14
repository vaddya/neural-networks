close all;
load('3.mat');
P = P;
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

net = init_ff(P, T, 30);
net = train(net, P(trainIdx,:)', T(trainIdx)');
Y = sim(net, P(testIdx,:)') > 0.5;
err = perform(net, T(testIdx,:)', Y)

plot_classes(P, sim(net, P') > 0.5)

function net = init_ff(P, T, N)
    net = newff(P, T, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 1;
    net.layers{2}.transferFcn = 'softmax';
    net.performFcn = 'crossentropy';
    net.trainFcn = 'trainscg';
    net.trainParam.sigma = 1e-4;
    net.trainParam.lambda = 1e-2;
    net.trainParam.epochs = 2000;
    net.trainParam.time = Inf;
    net.trainParam.goal = 0;
    net.trainParam.min_grad = 1e-05;
    net.trainParam.max_fail = 10;
    net = init(net);
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