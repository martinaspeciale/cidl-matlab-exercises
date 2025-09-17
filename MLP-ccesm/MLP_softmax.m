function rA = MLP_softmax(rZ)
% This function computes the softmax function for Z, where Z 
% is assumed to be a C-by-B matrix,
% C beings the number of classes and B the
% number of patterns in the mini-batch (B can also be equal to one).
%
% % Example 1
% rZ = [1.3; 5.1; 2.2; 0.7; 1.1]
% rA = MLP_softmax(rZ)  
% disp('(the expected output was [ 0.0202; 0.9025; 0.0497; 0.0111; 0.0165]'')');
% disp('');
% disp('Let us now check if the sum of the eleements of the output vector is one:');
% sum_rA = sum(rA)
%
% % Example 2
% rZ = [-2; 1; 3; -4]
% rA = MLP_softmax(rZ)  % expected [ 0.0059  0.1184  0.8749  0.0008 ]
% sum_rA = sum(rA)
%
% % Example 3
% rZ = randn(5,10)  % three outputs, 5 samples in the mini-batch
% rA = MLP_SoftMax(rZ)
% sum_rA = sum(rA)

rA = zeros(size(rZ));
total = sum(exp(rZ),1);

for p = 1:size(rZ,2)
    rA(:,p) = exp(rZ(:,p))/total(p);
end

% % NB: The sum of rA along the vertical (i.e., along the first dimension)
% % must be one, for each pattern
% 
% assert(sum(rA,1) == ones(1,size(rZ,2)))
