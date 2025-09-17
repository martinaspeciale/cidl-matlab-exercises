function [W1, W2] = MLP_initialize_weights(model)
%initialize weights to Unif[-1,1]

n_hidden = model.n_hidden;
n_features = model.n_features;
n_output = model.n_output;

W1 = 2*rand(1,n_hidden*(n_features+1))-1;
W1 = reshape(W1,[n_hidden, n_features+1]);

W2 = 2*rand(1,n_output*(n_hidden+1))-1;
W2 = reshape(W2,[n_output, n_hidden+1]);

end
