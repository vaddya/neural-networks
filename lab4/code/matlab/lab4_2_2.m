close all;
load('3.mat');
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

% domain = 2 .^ (-15 : 4);
% Q = range_spread(P, T, trainIdx, testIdx, domain)
% plot_quality(domain, Q);
% axis([1e-4 10 0 0.5]);

Tvec = class2vec(T(trainIdx)' + 1);
net = newpnn(P(trainIdx,:)', Tvec, 0.2);
net.layers{1}.size
Yvec = sim(net, P(testIdx,:)');
Y = vec2class(Yvec) - 1;
Q = calc_error(Y, T(testIdx)')
figure;
Tvec = class2vec(T(testIdx) + 1);
plotconfusion(Tvec, Yvec);

function Q = range_spread(P, T, trainIdx, testIdx, domain)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T(trainIdx)' + 1);
        net = newpnn(P(trainIdx,:)', Tvec, spread);
        Yvec = sim(net, P(testIdx,:)');
        Y = vec2class(Yvec) - 1;
        Q(i) = calc_error(Y, T(testIdx)');
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