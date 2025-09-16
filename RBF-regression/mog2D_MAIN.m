%% Radial Basis Function Network (RBF) for REGRESSION
%  tested on a 2D synthetic dataset,
%  the 2D Mixture of Gaussians function


% Marco Cococcioni, 10 December 2023

clear all; close all; clc
rng('default');


Ninput = 2;         % number of inputs
Ntrain = 150*150;   % number of training pattern (put a square number here)

Ntest  = 2500;

[Xtrain,ytrain] = mog2D_gen(Ntrain,true);
[Xtest,ytest]   = mog2D_gen(Ntest,false);

shuffled_ind = randperm(Ntrain);
Xtrain = Xtrain(shuffled_ind,:);
ytrain = ytrain(shuffled_ind);

%% set model parameters
model.n_output = 1;                             % single output regression problem (SORP)
model.n_features = Ninput;                      % number of inputs
model.n_hidden = 50;                             % number of centres (it concides with the number of neurons of the hidden layer)
model.epsilon  = 0.1; % 0.3 is the default      % epsilon of the gaussian RBF kernel, according to the Wikipedia definition

% model.centres_generation_method = 'random';     % centres generation method (random)
model.centres_generation_method = 'clustering';   % centres generation method (using clustering)
% model.centres_generation_method = 'debug';      % centres generation method (using best centres - debug mode)


if gpuDeviceCount > 0
    disp('All the computations are accelerated, by using the GPU(s)')
    Xtrain = gpuArray(Xtrain);
    ytrain = gpuArray(ytrain);
    Xtest  = gpuArray(Xtest);
    ytest  = gpuArray(ytest);   
end

%% RBF offline training
[model,W1,W2] = RBF_train_offline(Xtrain, ytrain, model);

ytrain_pred = RBF_predict(Xtrain, W1, W2, model.epsilon);
ytest_pred  = RBF_predict(Xtest,  W1, W2, model.epsilon);

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


