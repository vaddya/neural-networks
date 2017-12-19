function plot_target_and_approx(net, P, T)
    figure;
    hold on;
    grid on;
    plot(P, T, 'linewidth', 2);
    plot(P, sim(net, P), 'linewidth', 2);
    xlabel('x');
    ylabel('y');
    legend('target', 'approx');
    axis([0 1 0 1]);
end