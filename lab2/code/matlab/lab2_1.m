load('5.mat');

linear_newlin(P, T);
linear_newlind(P, T);

function linear_newlin(P, T)
    [Ptrain, Ttrain, ~, ~] = split(P, T);

    net = newlin(Ptrain, 1);
    net.trainParam.epochs = 1;
    net = init(net);

    X = 0 : 0.01 : 1;
    Y = zeros(5, 101);
    i = 1;
    while (i < 5)
        net = train(net, Ptrain, Ttrain);
        Y(i, :) = sim(net, X);
        i = i + 1;
    end

    plot_progress(P, T, X, Y);
    saveas(gcf, '../../pics/1_2_1.png');
end

function linear_newlind(P, T)
    [Ptrain, Ttrain, ~, ~] = split(P, T);
    net = newlind(Ptrain, Ttrain);
    plot_model(net, P, T);
    saveas(gcf, '../../pics/1_2_2.png');
end

function plot_model(net, P, T)
    figure;
    hold on;
    plot(P, T, 'r');
    X = 0 : 0.01 : 1;
    Y = sim(net, X);
    plot(X, Y);
    xlabel('X');
    ylabel('Y');
    axis([0 1 0 1]);
end

function plot_progress(P, T, X, Y)
    figure;
    hold on;
    plot(P, T);
    i = 1;
    while (i < 6)
        plot(X, Y(i, :));
        i = i + 1;
    end
    xlabel('X');
    ylabel('Y');
    legend('(P,T)', 'i=1', 'i=2', 'i=3', 'i=4');
    axis([0 1 0 1]);
end