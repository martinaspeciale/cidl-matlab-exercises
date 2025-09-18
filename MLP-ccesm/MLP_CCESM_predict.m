function [y_pred] = MLP_CCESM_predict(X, W1, W2)
% Predict class labels for all the observations in X, 
% where each row of X is a distinct observation.

[rA2,A1,A0,rZ1] = MLP_CCESM_forward(X, W1, W2);
[~, argmax] = max(rA2);
y_pred = argmax - 1;     %1:number_of_classes is mapped into 0:(number_of_classes-1)

end




