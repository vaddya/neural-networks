delta = 0.03;

y = @(x) 2 * (x - 0.4).^2 + 0.3;
y_classifier = @(x) 2 * (x(:, 1) - 0.4).^2 + 0.3 > x(:, 2);

x = 0 : delta : 1;

figure;
hold on;
plot(x, y(x));

x1 = 0 : delta : 1;
x2 = 0 : delta : 1;
[X1, X2] = meshgrid(x1, x2);
X = [X1(:) X2(:)];
group = y_classifier(X);

gscatter(X(:,1), X(:,2), group, 'rb', 'ox') 
axis([0 1 0 1]);
saveas(gcf, '../../pics/5_1_2.png');