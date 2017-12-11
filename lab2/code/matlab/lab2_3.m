close all;
load('5.mat');
T = double(T);

maxlr = 2 * maxlinlr(P, 'bias');
delta_epochs = 30;
n_delta = 10;
net = newlin(P, 1, 0, maxlr);
net.iw{1} = 0.5;
net.b{1} = 0;
net.trainparam.epochs = delta_epochs;
w = zeros(n_delta + 1, 2); 
w(1, :) = [net.iw{1} net.b{1}];
for i = 1: n_delta
    net = train(net,P,T);
    w(i+1, :) = [net.iw{1} net.b{1}];
end
subplot(2,1,1);
w_range = -1 : 0.1 : 1;
b_range = -1 : 0.1 : 1;
ES = errsurf(P,T,w_range,b_range,'purelin'); 
contour(w_range, b_range, ES); 
hold on; grid on;
plot(w(:,1), w(:,2), '-ro');
xlabel('w_1'); 
ylabel('b');
axis([-1 1 -1 1]);
subplot(2,1,2);
plot(P,T, '-ro');
hold on; grid on;
Y = sim(net,P);
plot(P,Y, '-bx');
legend({'Desire', 'Real'});
xlabel('x'); 
ylabel('y');
axis([0 1 0 1]);