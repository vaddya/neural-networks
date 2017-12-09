load('2.mat')
P = double(P)
T = double(T)

net = network(1, 2, [1; 1], [1; 0], [0 0; 1 0], [0 1]);

net.inputs{1}.size = 5;
net.layers{1}.size = 8;
net.layers{2}.size = 1;

net.layers{1}.transferFcn = 'hardlim'
net.layers{2}.transferFcn = 'hardlim'

net.trainFcn = 'trainc';

net.IW{1, 1} = [ 
    -10, -10, 1, -10, 1;
    -10, 1, -10, 1, -10;
    -10, 1, 1, -10, 1;
    -10, 1, 1, 1, 1;
    1, -10, -10, -10, -10;
    1, -10, 1, -10, 1;
    1, 1, -10, -10, -10;
    1, 1, -10, 1, -10;
];
net.b{1} = [ -1.5, -1.5, -2.5, -3.5, -0.5, -2.5, -1.5, -2.5 ]';

net.LW{2,1} = [ 1, 1, 1, 1, 1, 1, 1, 1 ];
net.b{2} = -0.5;

Y = sim(net, P');
err = Y ~= T';
err
gensim(net)