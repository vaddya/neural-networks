close all;

fcnW = {'initzero', 'rands', 'randsmall', 'midpoint',...
            'randnc', 'randnr', 'initlvq', 'initsompc'};
fcnb = {'initzero', 'rands', 'randsmall', 'initcon'};

net = network(1, 2, [1; 1], [1; 0], [0 0; 1 0], [0 1]);
net.inputs{1}.size = 1;
net.layers{1}.size = 3;
net.layers{2}.size = 2;
%net = net_initnw(net);
net = net_initwb(net, fcnW{2}, fcnb{3}, fcnW{7}, fcnb{1});

IW11 = net.IW{1, 1}
b1 = net.b{1}
LW21 = net.LW{2, 1}
b2 = net.b{2}

function net = net_initnw(net)
    net.initFcn = 'initlay';
    net.layers{1}.initFcn = 'initnw';
    net.layers{2}.initFcn = 'initnw';
    net = init(net);
end

function net = net_initwb(net, iw11, b1, lw21, b2)
    net.initFcn = 'initlay';
    net.layers{1}.initFcn = 'initwb';
    net.layers{2}.initFcn = 'initwb';
    net.inputWeights{1, 1}.initFcn = iw11;
    net.biases{1}.initFcn = b1;
    net.layerWeights{2, 1}.initFcn = lw21;
    net.biases{2}.initFcn = b2;
    net = init(net);
end