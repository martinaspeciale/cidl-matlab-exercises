%% Multi-Layer Perceptron (MLP) on SYNTHETIC 4-class classification problem in 2D

clear all; close all;
rng('default');

Nclasses = 4;          % number of classes
Ninput = 2;            % number of inputs
displacement = 2.5;    % spatial separation between the classes (kind of average distance)
NtrainPerClass = 300;  % number of training pattern per class

NtestPerClass = NtrainPerClass;
[Xtrain,ytrain, Xtest, ytest] = synth_gen(NtrainPerClass, NtestPerClass, displacement,Ninput,Nclasses);

figure
synth_display(Xtrain,ytrain);

%% set model parameters
model.n_output = Nclasses;
model.n_features = Ninput;
model.n_hidden = 25;
model.l1 = 0;
model.l2 = 0.1;
model.epochs = 100;
model.eta = 0.001;
model.alpha = 0.001;
model.decrease_const = 0.00001;
model.minibatches = size(Xtrain,1)/10; % number of mini batches

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

%% confusion matrix and confusion chart
confusionmat(ytest,ytest_pred')
figure
confusionchart(ytest,ytest_pred')


