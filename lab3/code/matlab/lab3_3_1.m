close all;
load('3.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

plot_train_and_test(P, T, trainIdx, testIdx);

Q_all = zeros(4, 50);
Q_all(4,:) = range_hidden_neurons(50, P, T, trainIdx, testIdx);

plot_all_quality(Q_all);

theshold = 0.5;
net = init_ff(P, T, 10);
net = train(net, P(trainIdx,:)', T(trainIdx)');
Y = sim(net, P(testIdx,:)') > theshold;
err = perform(net, T(testIdx)', Y)

plot_2_classes(P, sim(net, P') > theshold);

function Q = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    treshold = 0.5;
    Q = zeros(1, N);
    for i = 1 : N
        net = init_ff(P, T, i);
        net = train(net, P(trainIdx,:)', T(trainIdx)');
        Y = sim(net, P(testIdx,:)') > treshold;
        Q(i) = perform(net, T(testIdx)', Y);
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

    net = set_train_param(net, type_train_func);
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