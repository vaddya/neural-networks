load('3.mat')
P = double(P)

net = network(1, 3, [1; 1; 1], [1; 0; 0], [0 0 0; 1 0 0; 0 1 0], [0 0 1]);

net.inputs{1}.size = 2;
net.layers{1}.size = 8;
net.layers{2}.size = 2;
net.layers{3}.size = 1;

net.layers{1}.transferFcn = 'hardlim'
net.layers{2}.transferFcn = 'hardlim'
net.layers{3}.transferFcn = 'hardlim'

net.IW{1, 1} = [
    1, -1;
    -1, -1;
    -1, 1;
    1, 1;
    1, 0;
    0, -1;
    -1, 0;
    0, 1;
];
net.b{1} = [ 0.5, 1.5, 0.5, -0.5, -0.4, 0.6, 0.6, -0.4 ]';

net.LW{2, 1} = [ 
    1, 1, 1, 1, 0, 0, 0, 0;
    0, 0, 0, 0, 1, 1, 1, 1;
];
net.b{2} = [ -3.5, -3.5 ]';

net.LW{3, 2} = [ 1, -2 ];
net.b{3} = -0.5;

err = sim(net, P') ~= T';
sum(err)
%sim(net, P')
gensim(net)