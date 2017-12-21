close all;
load('4.mat');
T = double(T);

[Pdec, Tdec, idx] = decrease(P, T, 0.2);

domain = 2 .^ (-15 : 5);
Q = range_spread(P, T, domain, idx)
plot_quality(domain, Q);
axis([2^(-15) 2^5 0 1]);

% Tvec = class2vec(Tdec');
% net = newpnn(Pdec', Tvec, 0.01);
% net.layers{1}.size
% Yvec = sim(net, P');
% Y = vec2class(Yvec);
% Q = calc_error(Y', T)
% plot_8_classes(P, Yvec);
% figure;
% Tvec = class2vec(T');
% plotconfusion(Tvec, Yvec);

function Q = range_spread(P, T, domain, idx)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T(idx)');
        net = newpnn(P(idx,:)', Tvec, spread);
        Yvec = sim(net, P');
        Y = vec2class(Yvec);
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