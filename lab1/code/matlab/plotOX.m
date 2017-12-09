rng(0,'twister');

a = 1;
b = 4;
x1 = (b - a) .* rand(1000, 1) + a;
x2 = (b - a) .* rand(1000, 1) + a;
group = sim(net, [x1'; x2']);

figure; 
gscatter(x1, x2, group, 'br', 'ox');
xlabel('x_1');
ylabel('x_2');
axis([a b a b]);
saveas(gcf, '../../pics/1_5_1.png');