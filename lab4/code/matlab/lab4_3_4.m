close all;
load('4.mat');
T = double(T);

ratio_domain = 0.05 : 0.05 : 1;
spread_domain = 10 .^ (-6 : 1);
%Q = range_ratio_spread(P, T, ratio_domain, spread_domain);
plot_error_surface(ratio_domain, spread_domain, Q);

function Q = range_ratio_spread(P, T, ratio_domain, spread_domain)
    Q = zeros(length(ratio_domain), length(spread_domain)); 
    i = 1;
    for ratio = ratio_domain
        [~, ~, idx] = decrease(P, T, ratio);
        j = 1;
        for spread = spread_domain
            Tvec = class2vec(T(idx)');
            net = newpnn(P(idx,:)', Tvec, spread);
            Yvec = sim(net, P');
            Y = vec2class(Yvec);
            Q(i,j) = calc_error(Y', T);
            j = j + 1;
        end
        i = i + 1;
    end
end

function plot_error_surface(ratio, spread, Q)
    figure;
    grid on;
    surf(ratio, spread, Q');
    set(gca,'YScale','log')
    xlabel('ratio');
    ylabel('spread');
    zlabel('perform');
end