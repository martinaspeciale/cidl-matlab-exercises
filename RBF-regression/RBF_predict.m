function [y_pred] = RBF_predict(X, W1, W2, epsilon)
% Predict the outputs for all the observations in X,
% where each row of X is a distinct observation.

rA2 = RBF_forward(X, W1, W2, epsilon);
y_pred = rA2;

end




