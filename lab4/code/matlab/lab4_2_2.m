close all;
load('3.mat');
T = double(T);

%domain = 2 .^ (-10 : 4);
%Q = range_spread(P, T, domain)
%plot_quality(domain, Q);
%axis([1e-3 10 0 0.5]);

Tvec = class2vec(T' + 1);
net = newpnn(P', Tvec, 0.01);
net.layers{1}.size
Yvec = sim(net, P');
Y = vec2class(Yvec) - 1;
Q = perform(net, T', Y);
plot_2_classes(P, Y);
plotconfusion(Tvec, Yvec);

function Q = range_spread(P, T, domain)
    Q = zeros(1, length(domain)); 
    i = 1;
    for spread = domain
        Tvec = class2vec(T' + 1);
        net = newpnn(P', Tvec, spread);
        [~, Q(i)] = netsim(net, P, T);
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