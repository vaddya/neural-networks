close all;
load('3.mat');
P = double(P);
T = double(T);
plot_desired_classes(P, T);

net = newlin(P, 1);
net.inputs{1}.size = 2;
net.trainParam.goal = 0.01;
net.trainFcn = 'trainc';
net = init(net);

[Ptrain, Ttrain, Ptest, Ttest] = split(P', T');

net = train(net, Ptrain, Ttrain);

threshold = 0.5;
Ytrain = sim(net, Ptrain) > 0.5;
Etrain = find_error(Ttrain, Ytrain)

Ytest = sim(net, Ptest) > 0.5;
Etest = find_error(Ttest, Ytest)

plot_classes(net);

function [Ptrain, Ttrain, Ptest, Ttest] = split(P, T)
    [Train, Test, ~] = dividerand([P; T], 0.7, 0.3, 0);

    Ptrain = Train(1:2, :);
    Ttrain = Train(3, :);
    Ptest = Test(1:2, :);
    Ttest = Test(3, :);
end

function error =  find_error(T, Y)
    err = T ~= Y;
    error = sum(err) / length(err);
end

function plot_desired_classes(P, T)
    figure;
    gscatter(P(:,1), P(:,2), T, 'br', 'ox');
    xlabel('x_1');
    ylabel('x_2');
    axis([0 1 0 1]);   
    saveas(gcf, '../../pics/2_1.png');
end

function plot_classes(net)
    delta = 0.025;
    x1 = 0 : delta : 1;
    x2 = 0 : delta : 1;
    [X1,X2] = meshgrid(x1,x2);
    X = [X1(:) X2(:)];
    threshold = 0.5;
    Y = sim(net, X') > threshold;

    figure; 
    gscatter(X(:,1), X(:,2), Y, 'br', 'ox');
    xlabel('x_1');
    ylabel('x_2');
    axis([0 1 0 1]);    
    saveas(gcf, '../../pics/2_2.png');
end