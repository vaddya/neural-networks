close all;
load('3.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

threshold = 0.5;
net = init_ff(P, T, 30);
net = train(net, P(trainIdx,:)', T(trainIdx)');
Y = sim(net, P(testIdx,:)') > threshold;
err = perform(net, T(testIdx,:)', Y)

plot_2_classes(P, sim(net, P') > threshold)

function net = init_ff(P, T, N)
    net = newff(P, T, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 1;
    %net.layers{2}.transferFcn = 'softmax';
    net.performFcn = 'crossentropy';
    net.performParam.regularization = 0.1;
    net.performParam.normalization = 'none';
    net.outputs{length(net.layers)}.processParams{2}.ymin = 0;
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