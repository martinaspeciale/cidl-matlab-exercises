function [e, MSE_loss] = lin_regr_assuming_MSE_and_using_GD(U,y,eta,iter)
% This function performs the linear regression assuming the MSE
% as the loss function (Mean Squared Error) and gradient descent.
%
% The function computes the column vector e, which can be imagined as
% 
%    e = [ b
%          w_1
%          ...
%          w_D  ];
%
e = zeros(size(U,2),1);
MSE_loss = zeros(iter,1);
N = size(U,1);
for j=1:iter
    hat_y = U*e;
    MSE_loss(j) = sum((hat_y-y).^2)/(2*N);
    e = e - eta*U'*(hat_y-y)/N;
end
end % end of the main function
