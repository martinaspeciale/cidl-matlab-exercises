function [rA2,A1,A0,rZ1] = MLP_MSELIN_forward(P, W1, W2)
% Compute the forward step

rA0 = P';               % rA0 is the "reduced A0" and it coincides with the transpose of the tall input matrix (nObs x nInput)
A0  = MLP_extend(rA0);  % A0  = Ext(rA0).     It is the "extended" version of rA0, obtained by it by adding a row of ones as its new first row
rZ1 = W1*A0;            % rZ1 = \sum(W1,A0).  It is the pre-activation at layer 1 (the hidden one)
rA1 = MLP_sigmoid(rZ1); % rA1 = \sigma(rZ1).  It is the output of the first layer (the hidden one)
A1  = MLP_extend(rA1);  % A1  = Ext(rA1).     It is the extended version of rA1
rZ2 = W2*A1;            % rZ2 = \sum(W2,A1).  It is the pre-activation at layer 2 (the output one)
rA2 = rZ2;              % rA2 is the output of the second layer (the output one). It is reduced, i.e. unextended.

end

