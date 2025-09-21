function [y_pred] = MLP_MSELIN_predict(P, W1, W2)
% Predict the outputs for all the observations in X,
% where each row of X is a distinct observation.

[rA2,A1,A0,rZ1] = MLP_MSELIN_forward(P, W1, W2);
y_pred = rA2;

end




