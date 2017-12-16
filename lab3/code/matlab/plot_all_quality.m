function plot_all_quality(Q_all)
    figure;
    hold on;
    grid on;
    for i = 1 : size(Q_all, 1)
        plot(1:length(Q_all(i,:)), Q_all(i,:), 'linewidth', 2);
    end
    legend('trainlm', 'trainbfg', 'traingdx', 'traincgf');
    xlabel('neurons'); 
    ylabel('perform');
end