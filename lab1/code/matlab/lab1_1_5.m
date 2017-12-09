load('1_big.mat')
P_big = double(P_big)
T_big = double(T_big)

net = newp([0 5; 0 5], 1);

net.IW{1,1} = [-1 1]; 
net.b{1} = -1;

net.trainFcn = 'trainr';
net.layers{1}.transferFcn = 'hardlim'

train(net, P_big', T_big')

%sim(net, P_big')

%gensim(net)