close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

type_train_func = 12;    % Функция обучения: 
%1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
%6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
%11-trainbfg, 12-trainoss, 13-trainbr

net = newff(P, T, 20);
net = init(net);
net = set_train_param(net, type_train_func);
net = train(net, P(trainIdx), T(trainIdx));

Y = sim(net, P(testIdx));
err = perform(net, T(testIdx), Y)