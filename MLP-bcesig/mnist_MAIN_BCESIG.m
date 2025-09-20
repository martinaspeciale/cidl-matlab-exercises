%% Multi-Layer Perceptron (MLP) on MNIST DIGIT RECOGNITION PROBLEM

clear all; close all;
rng('default');

%% load data
classes = 0:9;
Ntrain = 60000;
[Xtrain, ytrain, Xtest, ytest] = mnist_load(classes, Ntrain);

figure;
idx = randperm(Ntrain); idx = idx(1:64);
mnist_display(Xtrain(idx,:));

%% set model parameters
model.n_output = 10;
model.n_features = size(Xtrain,2);
model.n_hidden = 50;
model.l1 = 0;
model.l2 = 0.1;
model.epochs = 30;
model.eta = 0.001;
model.alpha = 0.001;
model.decrease_const = 0.00001;
model.minibatches = 20;

%% MLP
[model,W1,W2] = MLP_BCESIG_train(Xtrain, ytrain, model);

ytrain_pred = MLP_BCESIG_predict(Xtrain, W1, W2);
ytest_pred  = MLP_BCESIG_predict(Xtest,  W1, W2);

%% compute accuracy
acc = sum(ytrain' == ytrain_pred) / size(Xtrain,1);
fprintf('Training accuracy: %.2f\n',(acc * 100));

acc = sum(ytest' == ytest_pred) / size(Xtest,1);
fprintf('Test accuracy: %.2f\n',(acc * 100));

%% generate plots
figure;
plot(model.cost); 
title('MLP Training Loss'); grid on;
ylabel('Loss'); xlabel('Epochs x Minibatch');

%% notes

