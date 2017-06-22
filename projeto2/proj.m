%% Run tranining simulation
vsat = 300;
lqrsat = 400;
noisePower = 1e3;
time = 200;
sim('train');
%% Create net
net = feedforwardnet([25]);
net = train(net, input', control');
%% create simulink block
gensim(net)