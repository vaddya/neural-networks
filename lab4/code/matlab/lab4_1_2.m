close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

domain = 2 .^ (-8 : 4);
Q = range_spread(P, T, domain, trainIdx, testIdx)
plot_quality(domain, Q);

%net = newrbe(P, T, 0.0001);
%plot_target_and_approx(net, P, T)

function Q = range_spread(P, T, domain, trainIdx, testIdx)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        net = newrbe(P(trainIdx), T(trainIdx), spread);
        Y = sim(net, P(testIdx));
        Q(i) = perform(net, T(testIdx), Y);
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