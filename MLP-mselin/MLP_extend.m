function A = MLP_extend(rA)
% Extend matrix rA (reduced A) by adding a row of ones as its new first row.
%
% % Example 1
%
% rA = [  3.2;
%        -1.7;
%         3.2;
%         4.8 ];
% A = MLP_extend(rA)
% 
% will return:
%
% A = [   1.0;
%         3.2;
%        -1.7;
%         3.2;
%         4.8  ];
%
%
% % Example 2
%
% rA = [  3.2 11.2;
%        -1.7 12.2;
%         3.2 13.2;
%         4.8 14.2];
% A = MLP_extend(rA)
% 
% will return:
%
% A = [   1.0,  1.0;
%         3.2, 11.2;
%        -1.7, 12.2;
%         3.2, 13.2;
%         4.8, 14.2 ];

A = ones(size(rA,1)+1, size(rA,2));
A(2:end,:) = rA; 


