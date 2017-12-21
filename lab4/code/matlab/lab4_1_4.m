close all;
load('5.mat');

[trainIdx, testIdx] = dividerand(length(P), 0.7, 0.3, 0);

domain = 2 .^ (-8 : 3);
Q = range_spread(P, T, trainIdx, testIdx, domain)
plot_quality(domain, Q);

% net = newgrnn(P, T, 1e-10);
% net.layers{1}.size
% plot_target_and_approx(net, P, T);

function Q = range_spread(P, T, trainIdx, testIdx, domain)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        net = newgrnn(P(trainIdx), T(trainIdx), spread);
        Y = sim(net, P(testIdx));
        net.layers{1}.size
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