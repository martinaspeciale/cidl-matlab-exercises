function sig = MLP_sigmoid(z)
% This function computes the sigmoid function for a scalar,
% a vector or a matrix.
%
% % Example 1
% MLP_sigmoid(5) % it is known to be 0.9933 (i.e., close to one)
%
% % Example 2
% MLP_sigmoid(-5) % it is known to be 0.0067 (i.e., close to zero)
%
% % Example 3
% MLP_sigmoid([5, -5, 0]) % it must ouput [0.9933 0.0067 0.5000], 
%                         % since the sigmoid in zero evaluates to 0.5

sig = 1./(1+exp(-z));
