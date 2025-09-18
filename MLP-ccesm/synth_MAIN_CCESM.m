%% Multi-Layer Perceptron (MLP) on SYNTHETIC 3-class classification problem in 2D

clear all; close all; clc
rng('default');

Nclasses = 4;          % number of classes
Ninput = 2;            % number of inputs

displacement = 2.5;    % spatial separation between the classes (kind of average distance).
                       % when displacement > 2.5 the four classes are well
                       % seprated. When it is < 1.5 they start to overlap
                       % more and more.                       

NtrainPerClass = 300;  % number of training pattern per class

NtestPerClass = NtrainPerClass;
[Ptrain,ytrain, Ptest, ytest] = synth_gen(NtrainPerClass, NtestPerClass, displacement,Ninput,Nclasses);

figure
synth_display(Ptrain,ytrain);

%% set model parameters
model.n_output = Nclasses;
model.n_features = Ninput;
model.n_hidden = 25;
model.l1 = 0;
model.l2 = 0.1;
model.epochs = 200;
model.eta = 0.001;
model.alpha = 0; % 0.001;  % peso da dare all'ultima correzione delta_W1 e delta_W2
model.decrease_const = 0.00001;
model.minibatches = 100; % size(Xtrain,1); % number of mini batches

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
confusionmat(ytest,ytest_pred')
figure
confusionchart(ytest,ytest_pred')


