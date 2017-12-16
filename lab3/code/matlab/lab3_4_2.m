close all;
load('4.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

Tvec = class2vec(T);
net = init_ff(P, Tvec, 25);
net = train(net, P(trainIdx,:)', class2vec(T(trainIdx)));
Yvec = sim(net, P(testIdx,:)');
Y = vec2class(Yvec);
err = perform(net, T(testIdx)', Y)

plot_8_classes(P, sim(net, P'));

function net = init_ff(P, Tvec, N)
    net = newff(P, Tvec, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 8;
    net.layers{2}.transferFcn = 'softmax';
    net.performFcn = 'crossentropy';
    net.performParam.regularization = 0.1;
    net.performParam.normalization = 'none';
    net.outputs{length(net.layers)}.processParams{2}.ymin = 0;
    net.trainFcn = 'trainscg';
    net.trainParam.epochs = 1000;
    net.trainParam.time = Inf;
    net.trainParam.goal = 0;
    net.trainParam.min_grad = 1e-15;
    net.trainParam.max_fail = 20;
    net = init(net);
end