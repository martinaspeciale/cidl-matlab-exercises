function sigma_prime_of_rZ1 = MLP_sigmoid_derivative(rZ)
% Evaluating the derivative of the sigmoid on each elements
% of the matrix rZ.
%
% % Example
%
% rZ = [  2.3,  2.4;
%        -1.2,  1.4;
%        +2.7, -1.2;  ]
%
% sigma_prime_of_rZ1 = MLP_sigmoid_derivative(rZ)
%
% will display a matrix of the same size, having values
%
% [ \sigma'{+2.3}, \sigma'{+2.4}; 
%   \sigma'{-1.2}, \sigma'{+1.4}; 
%   \sigma'{+2.7}, \sigma'{-1.2}; ]
%
% i.e., the following matrix:
%
% [ 0.0828    0.0763;
%   0.1779    0.1587;
%   0.0590    0.1779 ]
 
sigma_of_rZ = MLP_sigmoid(rZ);
sigma_prime_of_rZ1 = sigma_of_rZ.*(1-sigma_of_rZ);

