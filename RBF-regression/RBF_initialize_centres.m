function [model, W1] = RBF_initialize_centres(model,Xtrain,ytrain)

switch model.centres_generation_method
    case 'random'
        idx = randperm(size(Xtrain,1));
        W1 = Xtrain(idx(1:model.n_hidden),:);             
    case 'clustering'
        options = fcmOptions(NumClusters=model.n_hidden,...
                             MaxNumIteration=50,...
                             MinImprovement=0.001,...
                             Verbose=false);
        disp('Begin of clustering the training data using fuzzy c-means...')
        W1 = fcm(Xtrain,options);        
        disp('Clustering completed (therefore we now have the centres for our RBF)')
    case 'debug'
        if model.n_hidden ~= 3
            warning('forcing the number of hidden neurons to 3 since we are in debug mode')
            model.n_hidden = 3;
        end

        switch size(Xtrain,2)
            case 1
                W1 = [-8, -1, 7]';
            case 2
                W1 = [ [-8 -8]; [-1 -1]; [7 7] ];
            otherwise
                error('Unrecognized method')
        end
    otherwise 
        error('Unrecognized method')
end
model.W1 = W1;
end
