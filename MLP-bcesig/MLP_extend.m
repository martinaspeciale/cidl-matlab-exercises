function [X_new] = MLP_extend(X)
% Extend matrix X by adding the bias (a row of ones as the new first row)
X_new = ones(size(X,1)+1, size(X,2));
X_new(2:end,:) = X;
end

