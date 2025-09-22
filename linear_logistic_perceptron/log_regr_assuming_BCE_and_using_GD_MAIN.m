% LOGISTIC REGRESSION for a two-class classification problem
% This script uses the BCE loss function and gradient descent.

close all
clear
clc


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

figure('units','normalized','position',[.03,.1,0.45,.7])
plot(Xtrain(1:P/2,1),Xtrain(1:P/2,2),'sb')
set(gca,'nextplot','add');
plot(Xtrain(P/2+1:end,1),Xtrain(P/2+1:end,2),'pg')

xlim = get(gca,'XLim');
ylim = get(gca,'YLim');

XtrainExt = [ones(P,1), Xtrain];

%% Logistic Regression

% % release 1.0: uses Matlab mnrfit
% ext_w = mnrfit(Xtrain,ytrain+1)

% % relase 2.0: uses fit_logistic_using_BCE
eta = 0.1;
iter = 2000;
[ext_w, BCE_loss] = log_regr_assuming_BCE_and_using_GD(XtrainExt,ytrain,eta,iter);

%% Plot the decision boundary
syms x1 x2
fnn = 1./(1+exp(-(ext_w(1)+ext_w(2)*x1+ext_w(3)*x2))) -0.5;
h = fimplicit(fnn, [xlim, ylim]);
legend('Class A (y = 0)', 'Class B (y = 1)','Decision boundary')

figure('units','normalized','position',[0.5,.1,0.47,.7])
plot(1:iter, BCE_loss);
title('BCE_loss along the iterations','Interpreter','none')

fprintf('Fitted coefficients: \n')
disp(ext_w)

np = 50; % number_of_point_in_each_dimension, for 3D plotting purposes
[x1grid,x2grid] = meshgrid(linspace(xlim(1),xlim(2),np), linspace(ylim(1),ylim(2),np));
zgrid = 1./(1+exp(-(ext_w(1)+ext_w(2)*x1grid + ext_w(3)*x2grid)));
figure
surf(x1grid,x2grid,zgrid)

%% TODO: create a test set, then test the model on it
