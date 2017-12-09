close all;
clc;

delta = 0.03;
x1 = 0 : delta : 1;
x2 = 0 : delta : 1;
[X1, X2] = meshgrid(x1, x2);
P = [X1(:) X2(:)];

y_lin = @(x) 2 * x - 0.5;
y_nonlin = @(x) 2 * (x - 0.4).^2 + 0.3;

y_classifier_lin = @(x) 2 * x(:, 1) - 0.5 > x(:, 2);
y_classifier_nonlin = @(x) 2 * (x(:, 1) - 0.4).^2 + 0.3 > x(:, 2);
% T = y_classifier_lin(P);
T = y_classifier_nonlin(P);

P = P';
T = T';

minerr = 0.13;

trainf = {'trainc', 'trainr', 'trainb'};
learnf = {'learnp', 'learnpn'};

trainf_n = 2;
learnf_n = 2;

net = newp([0 1; 0 1], 1);

net.trainfcn = trainf{trainf_n};

net.layers{1}.transferFcn = 'hardlim';

net.inputWeights{1,1}.learnfcn = learnf{learnf_n};
net.layerWeights{1,1}.learnfcn = learnf{learnf_n};
net.biases{1}.learnfcn = learnf{learnf_n};

net.inputWeights{1,1}.initFcn = 'rands'; 
net.biases{1}.initFcn = 'rands'; 

net = init(net);

% net.trainParam.epochs = 1;
% net.trainParam.goal = 0;
net.trainParam.epochs = 100;
net.trainParam.goal = minerr;

err = 100;
e = zeros(1, 100);
iw = zeros(2, 100);
b = zeros(1, 100);
i = 1;
while (err > minerr && i < 2)
    net = train(net, P, T);
    Y = sim(net, P);
    err = std(Y - T);
    e(i) = err;
    iw(:,i) = net.IW{1,1};
    b(i) = net.b{1};
    i = i + 1;
end
iw = iw(:, 1:i-1);
b = b(1:i-1);

figure;
hold on;
t = 0 : delta : 1;
plot(t, y_nonlin(t));
gscatter(P(1,:), P(2,:), Y, 'rb', 'ox');
axis([0 1 0 1]);

epochs = length(iw(1,:));
t = 1 : 1 : epochs;

figure;
hold on;
plot(t, iw(1,:));
plot(t, iw(2,:));
plot(t, b);
legend('W1', 'W2', 'b');

t = 0 : 0.1 : 1;
figure;
hold on;
for i = 1 : epochs
    y = @(x) -(iw(1,i)*x + b(i)) / iw(2,i);
    if (i == 1 || mod(i,5) == 0 || i == epochs)
        plot(t, y(t), '-');
    end
end
axis([0 1 0 1]);

t = 1 : 1 : epochs;
figure;
plot(t, e(t));