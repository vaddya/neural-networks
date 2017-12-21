close all;
load('8.mat');
T(T == 0) = 10; % число 0 = класс 10
T = double(T);

[trainIdx, testIdx] = dividerand(length(P), 0.5, 0.5, 0);

% domain = 2 .^ (-10 : 10);
% Q = range_spread(P, T, domain, trainIdx, testIdx);
% plot_quality(domain, Q);
% axis([1e-2 1e3 0 1]);

Tvec = class2vec(T(trainIdx)');
net = newpnn(P(trainIdx,:)', Tvec, 10);
research(net, P, T)

function Q = range_spread(P, T, domain, trainIdx, testIdx)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T(trainIdx)');
        net = newpnn(P(trainIdx,:)', Tvec, spread);
        Yvec = sim(net, P(testIdx,:)');
        Y = vec2class(Yvec);
        Q(i) = calc_error(Y, T(testIdx));
        i = i + 1;
    end
end

function Q = research(net, P, T)
    Yvec = sim(net, P');
    Y = vec2class(Yvec);
    Q = calc_error(Y, T);
    plot_confusion(T, Y);
end

function plot_confusion(T, Y)
    figure;
    Tvec = class2vec(T');
    Yvec = class2vec(Y);
    plotconfusion(Tvec, Yvec);
end

function plot_quality(X, Q)
    figure;
    grid on;
    semilogx(X, Q, 'linewidth', 2);
    xlabel('spread');
    ylabel('peform');
end