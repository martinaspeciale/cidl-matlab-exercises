%% Multi-Layer Perceptron (MLP) for REGRESSION
%  tested on a 2D synthetic dataset (the sinc2D function)
%  This MLP has only one hidden layer, but it is easy to
%  add additional layers.

% Marco Cococcioni, 10 November 2023

clear all; close all; clc
rng('default');


Ninput = 2;         % number of inputs ( D = 2 )
Ntrain = 150*150;   % number of training pattern (put a square number here)

Ntest  = 2500;

[Xtrain,ytrain,XX1,XX2,YY] = sinc2D_gen(Ntrain);
sinc2D_display(XX1,XX2,YY);
[Xtest,ytest] = sinc2D_gen(Ntest);

shuffled_ind = randperm(Ntrain);
Xtrain = Xtrain(shuffled_ind,:);
ytrain = ytrain(shuffled_ind);

%% set model parameters
model.n_output = 1;        % single output regression problem (SORP)
model.n_features = Ninput; % number of inputs
model.n_hidden = 300;      % number of neurons of the hidden layer
model.epochs = 500;        % number of epochs
model.eta = 1e-6;          % learning rate
model.minibatches = 30;    % number of mini batches

% % Advanced model parameters (we will use them in the future)
% model.alpha = 0.001;
% model.decrease_const = 0.00001;
% model.l1 = 1e-5; % L1 regularisation weight
% model.l2 = 1e-5; % L2 regularisation weight


%% MLP
[model,W1,W2] = MLP_MSELIN_train(Xtrain, ytrain, model);

ytrain_pred = MLP_MSELIN_predict(Xtrain, W1, W2);
ytest_pred  = MLP_MSELIN_predict(Xtest,  W1, W2);

figure
subplot(1,2,1)
plot(ytrain, ytrain_pred, '.b')
title('Scatter plot (training set)')
xlabel('y (true)')
ylabel('y (pred)')
subplot(1,2,2)
plot(ytest, ytest_pred, '.r')
title('Scatter plot (test set)')
xlabel('y (true)')
ylabel('y (pred)')

%% compute accuracy (MSE)
acc_train = sum((ytrain' - ytrain_pred).^2) / (2*length(ytrain));
fprintf('Training accuracy (MSE): %g\n', acc_train);

acc_test = sum((ytest' - ytest_pred).^2) / (2*length(ytest));
fprintf('Test accuracy: %g\n', acc_test);

%% generate plots
figure;
plot(model.cost); 
title('MLP Training Loss'); grid on;
ylabel('Loss'); xlabel('Epochs x Minibatch');

