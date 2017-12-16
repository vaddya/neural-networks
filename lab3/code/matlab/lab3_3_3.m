close all;
load('3.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

treshold = 0.5;
net = init_ff(P, T, 15);
net = train(net, P(trainIdx,:)', T(trainIdx)');
Y = sim(net, P(testIdx,:)') > treshold;
err = perform(net, T(testIdx,:)', Y)

plot_2_classes(P, sim(net, P') > treshold)

function net = init_ff(P, T, N)
    net = newff(P, T, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 1;
    net.layers{2}.transferFcn = 'tansig';
    net.performFcn = 'sse';
    net = set_train_param(net, 9);
    net = init(net);
end