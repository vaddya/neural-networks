close all;
load('3.mat');
T = double(T);

[Pdec, Tdec, idx] = decrease(P, T, 0.1);

%domain = 2 .^ (-15 : 5);
%Q = range_spread(P, T, domain, idx)
%plot_quality(domain, Q);

Tvec = class2vec(Tdec' + 1);
net = newpnn(Pdec', Tvec, 0.01);
Yvec = sim(net, P');
Y = vec2class(Yvec) - 1;
Q = perform(net, T', Y)
plot_2_classes(P, Y);
figure;
Tvec = class2vec(T' + 1);
plotconfusion(Tvec, Yvec);

function [P, T, idx] = decrease(P, T, ratio)
    [idx, ~, ~] = dividerand(length(P), ratio, 1-ratio, 0);
    P = P(idx,:);
    T = T(idx);
end

function Q = range_spread(P, T, domain, idx)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T(idx)' + 1);
        net = newpnn(P(idx,:)', Tvec, spread);
        Yvec = sim(net, P');
        Y = vec2class(Yvec) - 1;
        Q(i) = perform(net, T', Y);
        i = i + 1;
    end
end

function plot_quality(X, Q)
    figure;
    grid on;
    semilogx(X, Q, 'linewidth', 2);
    xlabel('spread');
    ylabel('peform');
	axis([2^(-15) 2^5 0 0.5]);
end