close all;
load('4.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

plot_train_and_test(P, T, trainIdx, testIdx);

Q_all = zeros(4, 50);
Q_all(4,:) = range_hidden_neurons(50, P, T, trainIdx, testIdx);

plot_all_quality(Q_all);

Tvec = class2vec(T);
net = init_ff(P, Tvec, 10);
net = train(net, P(trainIdx,:)', class2vec(T(trainIdx)));
Yvec = sim(net, P(testIdx,:)');
Y = vec2class(Yvec);
err = perform(net, T(testIdx)', Y)

plot_8_classes(P, sim(net, P'));

function Q = range_hidden_neurons(N, P, T, trainIdx, testIdx)
    Q = zeros(1, N);
    Tvec = class2vec(T)
    for i = 1 : N
        net = init_ff(P, Tvec, i);
        net = train(net, P(trainIdx,:)', Tvec(:,trainIdx));
        Yvec = sim(net, P(testIdx,:)');
        Y = vec2class(Yvec);
        Q(i) = perform(net, T(testIdx)', Y);
    end
end

function net = init_ff(P, Tvec, N)
    net = newff(P, Tvec, N);
    net.inputs{1}.size = 2;
    net.layers{2}.size = 8;
    net = init(net);
    type_train_func = 11;    % Функция обучения: 
    %1-traingd, 2-traingda, 3-traingdm, 4-traingdx, 5-trainrp, 
    %6-traincgf, 7-traincgb, 8-traincgp, 9-trainscg, 10-trainlm, 
    %11-trainbfg, 12-trainoss, 13-trainbr
    net = set_train_param(net, type_train_func);
end

function plot_train_and_test(P, T, trainIdx, testIdx)
    figure;
    hold on;
    grid on;
    gscatter(P(trainIdx,1), P(trainIdx,2), T(trainIdx), 'rgbmbmrg', 'o');
    gscatter(P(testIdx,1), P(testIdx,2), T(testIdx), 'rgbmbmrg', 'x');
    xlabel('x1'); 
    ylabel('x2');
    axis([0 1 0 1]);
end