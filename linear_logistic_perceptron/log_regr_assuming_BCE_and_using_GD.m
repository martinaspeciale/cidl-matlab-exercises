function [ext_w, BCE_loss] = log_regr_assuming_BCE_and_using_GD(ext_X,y,eta,iter)
% This function performs the logistic regression assuming that the 
% number of classes to discriminate is two and that one is encoded as 0
% and the other as 1 (hence y is a vector of zeros and ones).
% The function uses the Binary Crossentropy Loss function.
%
% The function computes the column vector ext_w, which can be imagined as
% 
%    w = [  b      // where b is the bias
%          v_1
%          ...
%          v_D  ];

% Author: Marco Cococcioni, October 2024
ext_w = zeros(size(ext_X,2),1);
BCE_loss = zeros(iter,1);
B = size(ext_X,1);
for j=1:iter
    hat_y = mysigmoid(ext_w*ext_X);
    BCE_loss(j) = -(1/B)*sum(y.*log(hat_y)+(1-y).*log(1-hat_y));
    ext_w = ext_w - (eta/B)*ext_X'*(hat_y-y);
end
end % end of the main function

% Auxiliary function
function sig = mysigmoid( z )
% computes the sigmoid function (also called "logistic" function)
sig = 1./(1+exp(-z));
end % end of the auxiliary function
