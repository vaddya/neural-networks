close all;
load('5.mat');

%domain = 2 .^ (-5 : 3);
%Q = range_spread(P, T, domain)
%plot_quality(domain, Q);

net = newrbe(P, T, 0.0001);
plot_target_and_approx(net, P, T)

function Q = range_spread(P, T, domain)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        net = newrbe(P, T, spread);
        Y = sim(net, P);
        Q(i) = perform(net, T, Y);
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