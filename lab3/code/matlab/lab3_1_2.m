close all;

procFcns = {'fixunknowns', 'lvqoutputs', 'mapminmax', 'mapstd',...
            'processpca', 'removeconstantrows', 'removerows'};

net = feedforwardnet([3 2]);
net.layers{length(net.layers)}.transferFcn = 'purelin';

net.inputs{1}.processFcns = {'fixunknowns'};
%net.outputs{2}.processFcns = {'mapminmax'};

net.inputs{1}.size = 2;
%net.layers{1}.size = 3;
%net.layers{2}.size = 2;

net.IW{1, 1} = ones(3, 2);
net.b{1} = zeros(3, 1);
net.LW{2, 1} = ones(2, 3);
net.b{2} = zeros(2, 1);

fixunknowns([1 2 3; 4 NaN 6]);
mapminmax([1 3 5; 7 9 11]);
mapstd([1 2 3; 4 5 6]);
processpca([1 2 3; 4 5 6]);
removeconstantrows([3 3 3; 1 2 3]);
removerows([1 2 3; 4 5 6; 7 8 9], [1, 3]);

view(net)