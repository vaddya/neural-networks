load('1_big.mat')
P_big = double(P_big);
T_big = double(T_big);

net = newp([0 5; 0 5], 1);

net.trainFcn = 'trainr';
net.layers{1}.transferFcn = 'hardlim'

net = init(net);

net = train(net, P_big', T_big');
Y = sim(net, P_big');
perform(net, T_big', Y)

%gensim(net)