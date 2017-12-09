load('3.mat')
P = double(P);
T = double(T);

net = network(1, 3, [1; 1; 1], [1; 0; 0], [0 0 0; 1 0 0; 0 1 0], [0 0 1]);

%net.layers{1}.transferFcn = 'hardlim'
%net.layers{2}.transferFcn = 'hardlim'
%net.layers{3}.transferFcn = 'hardlim'

net.trainFcn = 'trainr';
net.performFcn = 'mae';

net.inputs{1}.size = 2;
net.layers{1}.size = 2;
net.layers{2}.size = 2;
net.layers{3}.size = 1;

net.inputWeights{1, 1}.learnFcn = 'learnp';
net.layerWeights{2, 1}.learnFcn = 'learnp';
net.layerWeights{3, 2}.learnFcn = 'learnp';
net.biases{1}.learnFcn = 'learnp';
net.biases{2}.learnFcn = 'learnp';
net.biases{3}.learnFcn = 'learnp';

net.inputWeights{1, 1}.initFcn = 'rands';
net.layerWeights{2, 1}.initFcn = 'rands';
net.layerWeights{3, 2}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';
net.biases{2}.initFcn = 'rands';
net.biases{3}.initFcn = 'rands';
net = init(net);

train(net, {[0; 0], [0.5; 0.5]}, {1, 0})
P = num2cell(P', 1);
T = num2cell(T');