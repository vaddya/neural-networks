rng(0,'twister');

a = 0;
b = 1;
x1 = (b - a) .* rand(1000, 1) + a;
x2 = (b - a) .* rand(1000, 1) + a;
group = sim(net, [x1'; x2']);

figure; 
gscatter(x1, x2, group, 'br', 'ox');
xlabel('x_1');
ylabel('x_2');
saveas(gcf, '../../pics/3_4_1.png');