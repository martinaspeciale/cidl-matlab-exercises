function [model,W1,W2] = RBF_train_offline(X, y, model)
% Generated cenrtes and then estimate optimal linear combination parameters
% W2 (the w_i of the wikipedia formulation)

[model, W1] = RBF_initialize_centres(model,X,y);

[rA2,A1] = RBF_forward(X, W1, ones(1,model.n_hidden+1), model.epsilon);

W2 = A1'\y; % this is a column vector of length H (the number of hidden neurons)
W2 = W2';   % now it is an Hx1 matrix, as expected

model.W2 = W2;

end


