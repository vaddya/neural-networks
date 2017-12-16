function plot_8_classes(P, Yvec)
    figure;
    hold on;
    grid on;
    Y = vec2class(Yvec);
    gscatter(P(:,1), P(:,2), Y, 'rgbmbmrg', 'ooooxxxx');
    xlabel('x1');
    ylabel('x2');
    axis([0 1 0 1]);
end