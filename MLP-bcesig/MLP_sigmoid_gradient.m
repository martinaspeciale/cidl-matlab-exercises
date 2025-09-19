function sigGrad = MLP_sigmoid_gradient(Z)
%compute sigmoid gradient
sig = MLP_sigmoid(Z);
sigGrad = sig.*(1-sig);
end
