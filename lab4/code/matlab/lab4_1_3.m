close all;
load('5.mat');

%domain = 10 .^ (-10 : 0);
%N = range_neurons(P, T, domain, 0.1, 100);
%plot_neurons(domain, N);

net = newrb(P, T, 0.01, 0.1, 100);
net.layers{1}.size
plot_target_and_approx(net, P, T)

function N = range_neurons(P, T, goal_domain, spread, maxneurons)
    N = zeros(1, length(goal_domain)); 
    i = 1;
    for error = goal_domain
        net = newrb(P, T, error, spread, maxneurons);
        N(i) = net.layers{1}.size;
        i = i + 1;
    end
end

function plot_neurons(X, N) 
    figure;
    grid on;
    semilogx(X, N, 'linewidth', 2);
    xlabel('goal');
    ylabel('neurons');
end