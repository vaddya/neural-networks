close all;
load('3.mat');
T = double(T);

[Pdec, Tdec, idx] = decrease(P, T, 0.2);

% domain = 2 .^ (-15 : 5);
% Q = range_spread(P, T, domain, idx)
% plot_quality(domain, Q);
% axis([2^(-15) 2^5 0 0.5]);

Tvec = class2vec(Tdec' + 1);
net = newpnn(Pdec', Tvec, 0.01);
Yvec = sim(net, P');
Y = vec2class(Yvec) - 1;
Q = calc_error(Y', T)
plot_2_classes(P, Y);
figure;
Tvec = class2vec(T' + 1);
plotconfusion(Tvec, Yvec);

function Q = range_spread(P, T, domain, idx)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T(idx)' + 1);
        net = newpnn(P(idx,:)', Tvec, spread);
        Yvec = sim(net, P');
        Y = vec2class(Yvec) - 1;
        Q(i) = calc_error(Y', T);
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