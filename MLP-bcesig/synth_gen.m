function [Xtrain,ytrain, Xtest, ytest] = synth_gen(NtrainPerClass,NtestPerClass,displacement,Ninput,Nclasses)
if nargin < 5
    Nclasses = 4;
end

assert(Nclasses == 4); % this function works only for Nclasses = 4

% Generating the training pattern
Xtrain = [ randn(NtrainPerClass,Ninput) + [-displacement,+displacement]; 
           randn(NtrainPerClass,Ninput) + [+displacement,+displacement]; 
           randn(NtrainPerClass,Ninput) + [+displacement,-displacement]; 
           randn(NtrainPerClass,Ninput) + [-displacement,-displacement]; ];

Ntrain = 4*NtrainPerClass;

ytrain = [ 0*ones(NtrainPerClass,1);   % class A
           1*ones(NtrainPerClass,1);   % class B
           2*ones(NtrainPerClass,1);   % class C
           3*ones(NtrainPerClass,1);]; % class D

shuffleTr = randperm(Ntrain);
Xtrain = Xtrain(shuffleTr,:);
ytrain = ytrain(shuffleTr);


% Generating the test pattern
Xtest  = [ randn(NtestPerClass,Ninput) + [-displacement,+displacement]; 
           randn(NtestPerClass,Ninput) + [+displacement,+displacement]; 
           randn(NtestPerClass,Ninput) + [+displacement,-displacement]; 
           randn(NtestPerClass,Ninput) + [-displacement,-displacement]; ];

ytest  = [ 0*ones(NtestPerClass,1);   % class A
           1*ones(NtestPerClass,1);   % class B
           2*ones(NtestPerClass,1);   % class C          
           3*ones(NtestPerClass,1);]; % class D

Ntest = NtestPerClass*4;

shuffleTs = randperm(Ntest);
Xtest = Xtest(shuffleTs,:);
ytest = ytest(shuffleTs);
