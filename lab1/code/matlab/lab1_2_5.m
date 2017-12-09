load('2.mat')
P = double(P)
T = double(T)

net = newp([ 0 1; 0 1; 0 1; 0 1; 0 1 ], 1);

net = init(net);

net.trainFcn = 'trainr';
net.layers{1}.transferFcn = 'hardlim'

train(net, P', T')

%sim(net, P_big')

%gensim(net)

sim(net, P')