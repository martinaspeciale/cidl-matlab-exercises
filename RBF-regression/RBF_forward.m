function [rA2,A1] = RBF_forward(P, W1, W2, epsilon)
% Compute the forward step

% P   is BxD
% W1  is HxD
% W2  is 1xH
% rA0 is DxB
% rZ1 is HxB 
% rA1 is HxB
%  A1 is (H+1)xB
% rZ2 is 1xB (the preactivation at the output layer, for the whole dataset, made by B patterns)
% rA2 is 1xB (the output for the whole dataset, made by B patterns)

rA0 = P';                          % rA0 is the traspose of the input training matrix
rZ1 = dist(W1,rA0);                % rZ1 is the pre-activation at layer 1 (the hidden one): the euclidean distance between each pattern and each neuron
rA1 = exp(-(epsilon^2*(rZ1.^2)));  % rA1 is the output of the first layer (the hidden one)
 A1 = RBF_extend(rA1);             %  A1 is the extended output of the first layer 
rZ2 = W2*A1;                       % rZ2 is the pre-activation at layer 2 (the output one)
rA2 = rZ2;                         % rA2 is the output of the second layer (the output one). It is reduced, i.e. unextended

end

