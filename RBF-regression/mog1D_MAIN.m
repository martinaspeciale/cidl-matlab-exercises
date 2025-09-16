%% Radial Basis Function Network (RBF) for REGRESSION
%  tested on a 1D synthetic dataset,
%  the 1D Mixture of Gaussians function

% Author: Marco Cococcioni, 10 December 2023

clear all; close all; clc
rng('default');


Ninput = 1;      % number of inputs
Ntrain = 300;    % number of training patterns
Ntest  = 200;    % number of test patterns

[Xtrain,ytrain] = mog1D_gen(Ntrain,true);
[Xtest, ytest]  = mog1D_gen(Ntest,false);

% shuffled_ind = randperm(Ntrain);
% Xtrain = Xtrain(shuffled_ind,:);
% ytrain = ytrain(shuffled_ind);

%% set model parameters
model.n_output = 1;                             % single output regression problem (SORP)
model.n_features = Ninput;                      % number of inputs
model.n_hidden = 30;                            % number of centres (it concides with the number of neurons of the hidden layer)
% model.epsilon  = 0.3;                         % epsilon of the gaussian RBF kernel, according to the Wikipedia definition
model.epsilon  = 0.3;                           % (the espilon used in the synthetic dataset is 0.3) here you can try a different value

% model.centres_generation_method = 'random';     % centres generation method (random)
model.centres_generation_method = 'clustering'; % centres generation method (using clustering)
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
plot(Xtrain,ytrain,'.b',Xtrain,ytrain_pred,'or');
legend('true','pred')

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

