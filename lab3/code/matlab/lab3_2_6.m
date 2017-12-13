close all;

figure;
hold on;
grid on;
plot(P, T, 'linewidth', 2);
for i = 1:4
    plot(P, batches(i,:), 'linewidth', 2)
end
legend('target', 'traingda', 'traingdm', 'traingdx', 'trainrp');
xlabel('x'); 
ylabel('y');

figure;
hold on;
grid on;
plot(P, T, 'linewidth', 2);
for i = 5:6
    plot(P, batches(i,:), 'linewidth', 2)
end
legend('target', 'traincgf', 'trainscg');
xlabel('x'); 
ylabel('y');

figure;
hold on;
grid on;
plot(P, T, 'linewidth', 2);
for i = 7:9
    plot(P, batches(i,:), 'linewidth', 2)
end
legend('target', 'trainbfg', 'trainlm', 'trainoss');
xlabel('x'); 
ylabel('y');