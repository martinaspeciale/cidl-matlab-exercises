% Script linregr_assuming_MSE_and_using_GD_MAIN
%
% LINEAR REGRESSION assuming the MSE as the loss function and
% using gradient descent.

% Marco Cococcioni, 3 November 2023

close all
clear
clc

%% Generate a dataset in two input dimensions
%  (the fitting code works for higher dimensions, 
%   but the used plots work only in 2 dimensions)

P = 1000; % number of patterns
noise_level = 2;
offset = 2;
true_e = [-4 +3 -7]'; % true model coefficients: e(1) + e(2)*x1 + e(3)*x2
disp('True coefficients:')
disp(true_e);

X = randn(P,2);

X = X + offset;

U = [ones(P,1), X]; % extended training set

y = U*true_e + noise_level*randn(P,1);

figure('units','normalized','position',[.03,.1,0.45,.7])
scatter3(X(:,1),X(:,2),y)

xlim = get(gca,'XLim');
ylim = get(gca,'YLim');


%% Linear Regression

% % release 1.0: uses Matlab backslash operator
% e = U\y;

% % relase 2.0: uses logregr_assuming_BCE_and_gd
eta = 0.1;
iter = 1000;
[e, MSE_loss] = lin_regr_assuming_MSE_and_using_GD(U,y,eta,iter);                    

set(gca,'NextPlot','add');
hat_y = U*e; % predicted output
scatter3(X(:,1),X(:,2),hat_y,'.r')
figure('units','normalized','position',[0.5,.1,0.47,.7])
plot(1:iter, MSE_loss);
title('MSE_loss along the iterations','Interpreter','none')

fprintf('Fitted coefficients: \n')
disp(e)

np = 50; % number_of_point_in_each_dimension, for 3D plotting purposes
[x1grid,x2grid] = meshgrid(linspace(xlim(1),xlim(2),np), linspace(ylim(1),ylim(2),np));
zgrid = e(1) + e(2)*x1grid + e(3)*x2grid;
figure
surf(x1grid,x2grid,zgrid)



%% TODO: create a test set, then test the model on it
