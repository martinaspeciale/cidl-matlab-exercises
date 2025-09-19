%% Multi-Layer Perceptron (MLP) on MNIST DIGIT RECOGNITION PROBLEM

clear all; close all; clc
rng('default');

%% load data
classes = 0:9;
Ntrain = 60000;
[Ptrain, ytrain, Ptest, ytest] = mnist_load(classes, Ntrain);

figure;
idx = randperm(Ntrain); idx = idx(1:64);
mnist_display(Ptrain(idx,:));

%% set model parameters
model.n_output = 10;
model.n_features = size(Ptrain,2);
model.n_hidden = 50;
model.l1 = 0;
model.l2 = 0.1;
model.epochs = 50;
model.eta = 0.001;
model.alpha = 0.001;
model.decrease_const = 0.00001;
model.minibatches = 50;

%% MLP
[model,W1,W2] = MLP_CCESM_train(Ptrain, ytrain, model);
 
ytrain_pred = MLP_CCESM_predict(Ptrain, W1, W2);
ytest_pred  = MLP_CCESM_predict(Ptest,  W1, W2);

%% compute accuracy
acc = sum(ytrain' == ytrain_pred) / size(Ptrain,1);
fprintf('Training accuracy: %.2f\n',(acc * 100));

acc = sum(ytest' == ytest_pred) / size(Ptest,1);
fprintf('Test accuracy: %.2f\n',(acc * 100));

%% generate plots
figure;
plot(model.cost); 
title('MLP Training Loss'); grid on;
ylabel('Loss'); xlabel('Epochs x Minibatch');

%% confusion matrix and confusion chart
confusionmat(ytest,uint8(ytest_pred'))
figure
confusionchart(ytest,uint8(ytest_pred'))

