close all;
load('3.mat');
T = double(T);

%domain = 2 .^ (-10 : 4);
%Q = range_spread(P, T, domain)
%plot_quality(domain, Q);
%axis([1e-3 10 0 0.5]);

net = init_pnn(T, P, 0.2);
[Y, Q] = netsim(net, P, T); Q
plot_2_classes(P, Y);

function Q = range_spread(P, T, domain)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        net = init_pnn(T, P, spread);
        Y = sim(net, P');
        [~, Q(i)] = netsim(net, P, T);
        i = i + 1;
    end
end

function net = init_pnn(T, P, spread)
    Tvec = class2vec(T' + 1);
    net = newpnn(P', Tvec, spread);
end

function [Y, Q] = netsim(net, P, T)
    Yvec = sim(net, P');
    Y = vec2class(Yvec) - 1;
    Q = perform(net, T', Y);
end

function plot_quality(X, Q)
    figure;
    grid on;
    semilogx(X, Q, 'linewidth', 2);
    xlabel('spread');
    ylabel('peform');
end