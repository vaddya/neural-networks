function plot_2_classes(P, Y)
    figure;
    hold on;
    grid on;
    gscatter(P(:,1), P(:,2), Y, 'br', 'ox');
    xlabel('x1'); 
    ylabel('x2');
    axis([0 1 0 1]);
end