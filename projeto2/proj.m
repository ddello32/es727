%% Run tanining simulation
vsat = 50;
lqrsat = 200;
noisePower = 1e3;
time = 49;
thres = pi/3;
adj = 2;
in = [];
out = [];
fin = [];
% in = in';
% out = out';
% fin = fin';
for init = 0 : pi/18 : 2*pi
    seed = floor(init*1000);
    sim('train');
    in = cat(1, in, input);
    out = cat(1, out, control);
    fin = cat(1, fin, final);
    figure
    result.plot()
end
time = 20;
for init = pi/2 : pi/12 : 3*pi/2
    seed = floor(init*1000);
    sim('train');
    in = cat(1, in, input);
    out = cat(1, out, control);
    fin = cat(1, fin, final);
    figure
    result.plot()
end
in = in';
out = out';
fin = fin';
%% Create net
net = feedforwardnet([45 4], 'trainbr');
net.trainParam.max_fail = 1000;
net.trainParam.epochs = 10000000;
net.divideParam.trainRatio = 1;
net.divideParam.testRatio = 0;
net.divideParam.valRatio = 0;
net = train(net, in, fin);
%% keep training
net.trainParam.epochs = 10000000;
net = train(net, in, fin);
%%
plot(sim(net, in)', 'b')
hold
plot(fin', 'r')
%% create simulink block
gensim(net)
%% Test results
noisePower = 1e3;
time = 100;
for init = 0 : pi/6 : 2*pi
    init*180/pi
    seed = floor(init*1000) + 7;
    sim('n2');
    figure,
    response.plot()
end