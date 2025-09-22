%% Script perceptron_MAIN.m

close all
clear
clc

% Input paramters
eta = 1e-4;

% Generate data
%% Generate a two-class classification problem in two input dimensions
%  (the fitting code works for higher dimensions, but the used plots work
%   only in 2D)

P = 300; % number of patterns (specify an even number, please)
distance_from_origin = 1.50;
offset = 5;
Xtrain = [ randn(P/2,2) + [-distance_from_origin,-distance_from_origin]; ...
           randn(P/2,2) + [distance_from_origin, +distance_from_origin] ];

Xtrain = Xtrain + offset;

ytrain = [ 0*ones(P/2,1); ...
           1*ones(P/2,1)];


figure('units','normalized','position',[.03,.1,0.45,.7]) % first figure (the one on the left)
plot(Xtrain(1:P/2,1),Xtrain(1:P/2,2),'sb')
set(gca,'nextplot','add');
plot(Xtrain(P/2+1:end,1),Xtrain(P/2+1:end,2),'pg')

xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

shuffled_ind = randperm(P);
Xtrain = Xtrain(shuffled_ind,:);
ytrain = ytrain(shuffled_ind);
XtrainExt = [ones(P,1), Xtrain];

% Initialize the vector of weights
w_init = 2*rand(size(XtrainExt,2),1)-1;


w = perceptron_train(XtrainExt,ytrain,w_init,eta);

%% Display results
fprintf('Fitted coefficients w: \n')
disp(w)

% Plot the decision boundary on the first figure
syms x1 x2
% fnn = 1./(1+exp(-(w(1)+w(2)*x1+w(3)*x2))) -0.5; 
fnn = sign(w(1)+w(2)*x1+w(3)*x2);
h = fimplicit(fnn, [xlim, ylim]);
legend('Class A (y = 0)', 'Class B (y = 1)','Decision boundary')

figure('units','normalized','position',[0.5,.1,0.47,.7]) % second figure (the one on the right)

np = 50; % number_of_point_in_each_dimension, for 3D plotting purposes
[x1grid,x2grid] = meshgrid(linspace(xlim(1),xlim(2),np), linspace(ylim(1),ylim(2),np));
%zgrid = 1./(1+exp(-(w(1) + w(2)*x1grid + w(3)*x2grid))); 
zgrid = sign(w(1) + w(2)*x1grid + w(3)*x2grid);
surf(x1grid,x2grid,zgrid)

%% TODO: create a test set, then test the model on it

