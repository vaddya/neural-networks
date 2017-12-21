close all;
load('4.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

% domain = 2 .^ (-15 : 4);
% Q = range_spread(P, T, trainIdx, testIdx, domain)
% plot_quality(domain, Q);
% axis([1e-4 10 0 1]);

Tvec = class2vec(T(trainIdx)');
net = newpnn(P(trainIdx,:)', Tvec, 0.0001);
net.layers{1}.size
Yvec = sim(net, P(testIdx,:)');
Y = vec2class(Yvec);
Q = calc_error(Y', T(testIdx))
figure;
Tvec = class2vec(T(testIdx)');
plotconfusion(Tvec, Yvec);
Yvec = sim(net, P');
plot_8_classes(P, Yvec);

function Q = range_spread(P, T, trainIdx, testIdx, domain)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T(trainIdx)');
        net = newpnn(P(trainIdx,:)', Tvec, spread);
        Yvec = sim(net, P(testIdx,:)');
        Y = vec2class(Yvec);
        Q(i) = calc_error(Y', T(testIdx,:));
        i = i + 1;
    end
end

function plot_quality(X, Q)
    figure;
    grid on;
    semilogx(X, Q, 'linewidth', 2);
    xlabel('spread');
    ylabel('peform');
end