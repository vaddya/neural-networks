load('2.mat')
P = double(P);
T = double(T);

net = newp([ 0 1; 0 1; 0 1; 0 1; 0 1 ], 1);

net.trainFcn = 'trainr';
net.layers{1}.transferFcn = 'hardlim'

net = init(net);

net = train(net, P', T')
Y = sim(net, P');
perform(net, T', Y)

%gensim(net)