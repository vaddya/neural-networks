load('3.mat')
P = double(P)
T = double(T)

net = newp([0 1; 0 1], 1);

net.IW{1,1} = [-1 1]; 
net.b{1} = 0;

net.trainFcn = 'trainr';
net.layers{1}.transferFcn = 'hardlim'

net = train(net, P', T')

%sim(net, P_big')

%gensim(net)