rng(0,'twister');

a = 0;
b = 1;
%x1 = (b - a) .* rand(2000, 1) + a;
%x2 = (b - a) .* rand(2000, 1) + a;
x1 = a : 0.015 : b;
x2 = a : 0.015 : b;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
Y = sim(net, X');
[~,Z] = max(Y);

figure; 
gscatter(X(:,1), X(:,2), Z, 'rgbmbmrg', '....xxxx');
xlabel('x_1');
ylabel('x_2');
axis([0 1 0 1]);
saveas(gcf, '../../pics/4_4.png');