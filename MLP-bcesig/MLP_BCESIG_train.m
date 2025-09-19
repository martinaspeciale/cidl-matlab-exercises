function [model,W1,W2] = MLP_BCESIG_train(X, y, model)
%learn weights from training data
[W1, W2] = MLP_initialize_weights(model);

l1 = model.l1;
l2 = model.l2;
eta = model.eta;
alpha = model.alpha;
epochs = model.epochs;
n_output = model.n_output;
minibatches = model.minibatches;  
decrease_const = model.decrease_const;

y_enc = encode_labels(y,n_output);
delta_W1_prev = zeros(size(W1));
delta_W2_prev = zeros(size(W2));

model.cost = Inf;

for i=1:epochs
    fprintf('Epoch: %d\n',i);
    
    %adaptive learning rate
    eta = eta / (1+decrease_const*i);
        
    %minibatch
    kk = floor(length(y)/minibatches);
    y = y(1:kk*minibatches);
    X = X(1:kk*minibatches,:);    
    I = reshape(1:length(y),minibatches,[]);
                  
    for i=1:minibatches
        
        idx = I(i,:);
        
        %feedforward        
        [rA2,A1,A0,rZ1] = MLP_BCESIG_forward(X(idx,:), W1, W2);
        % [A0,rZ1,A1,rZ2,rA2] = MLP_BCESIG_forward(X(idx,:), W1, W2);
        cost = get_BCE_cost(y_enc(:,idx), rA2, model, W1, W2);   
        model.cost = [model.cost, cost];        
        
        %compute gradient via backpropagation
        [delta_W1_unscaled, delta_W2_unscaled] = get_BCESIG_gradient(rA2,A1,A0,rZ1,y_enc(:,idx),W1,W2,l1,l2);
        % [delta_W1_unscaled, delta_W2_unscaled] = MLP_MSELIN_backprop(rA2,A1,A0,rZ1,y(idx)',W1,W2); %,l1,l2);
        
        delta_W1 = eta * delta_W1_unscaled;
        delta_W2 = eta * delta_W2_unscaled;

        W1 = W1 - (delta_W1 + (alpha * delta_W1_prev)); % gradient descent with momentum (alpha controls the momentum)
        W2 = W2 - (delta_W2 + (alpha * delta_W2_prev)); % idem for W2       
        
        delta_W1_prev = delta_W1;
        delta_W2_prev = delta_W2;
        
    end
    
end

model.W1 = W1;
model.W2 = W2;

end

function [onehot] = encode_labels(y, k)
%one-hot encoding
onehot = zeros(k,length(y));

for i = 1:length(y)
    val = y(i) + 1;      %0:(Nclasses-1)  -> 1:Nclasses
    onehot(val,i) = 1;
end

end

function [delta_W1_unscaled, delta_W2_unscaled] = get_BCESIG_gradient(rA2,A1,A0,rZ1,Y_enc,W1,W2,l1,l2)
%compute gradient step using backpropagation

% rA2   is CxB       (C is the number of the independent output class)
% A1    is (H+1)xB
% A0    is (D+1)xB
% rZ1   is HxB 
% Y_enc is CxB
% W1    is Hx(D+1)
% W2    is Cx(H+1)

% Step 1: compute dL_dZ2 of size CxB                % NB: rA2 coincides with Y_pred, while Y_enc is the true (one-hot encoded) output 
dL_dZ2 = rA2 - Y_enc;                               % NB: dL_dZ2 could be called "grad2", the gradient on the output layer with respect the pre-activation Z2
 
% Step 2: compute dL_dW2 % size Cx(H+1)
dL_dW2 = dL_dZ2*A1';                                % NB: dL_dW2 could be called "delta_W2_unscaled", because it is of the same size of W2 and stores the unscaled variation

% Step 3: compute dL_dA1 of size (H+1)xB 
dL_dA1 = W2'*dL_dZ2;

% Step 4: compute dL_drZ1 of size HxB (also sigma_prime_of_rZ1 has size HxB)
sigma_prime_of_rZ1 = MLP_sigmoid_gradient(rZ1);
dL_drZ1 = dL_dA1(2:end,:).*sigma_prime_of_rZ1;      % NB: dL_drZ1 could have been called "grad1",
                                                    % since it is the gradient at the first layer
                                                    % (the hidden one), with respect to Z1

% Step 5: compute dL_dW1 of size Hx(D+1)
dL_dW1 = dL_drZ1*A0';                               % NB: dL_dW1 could be called "delta_W1_unscaled", 
                                                    % because it is of the same size of W2 and stores the unscaled 
                                                    % variation of W1

% Step 6: regularise or not
delta_W1_unscaled = dL_dW1;
delta_W2_unscaled = dL_dW2;

% delta_W1_unscaled(:,2:end) = dL_dW1(:,2:end) +  W1(:,2:end)*(l1+l2);
% delta_W2_unscaled(:,2:end) = dL_dW2(:,2:end) +  W2(:,2:end)*(l1+l2);

end


function [cost] = get_BCE_cost(y_enc, y_pred, model, W1, W2)
%compute cost function
l1 = model.l1;
l2 = model.l2;

term1 = -y_enc.*log(y_pred);
term2 = (1-y_enc).*log(1-y_pred);
cost = sum(term1-term2); % one cost term for each pattern (a vector, overall)
cost = sum(cost);        % a single scalar cost value (associated to all the patterns in the minibatch)
L1_term = L1_reg(l1,W1,W2);
L2_term = L2_reg(l2,W1,W2);

cost = cost + L1_term + L2_term;

%---------------------------------------------------------------------------------------
% More details on terms term1 and term2:
%
% term1(i,p) is equal the first term of the binary cross-entropy:  
% -y_enc(i,p) *log(y_pred(i,p)), where y_enc(i,p) is the true output of the i-th class,
% p-th pattern, assuming the one hot encoding.
% 
% term2(i,p) is a C-by-P matrix (when using minibaches, otherwise is a
% column vector), which contains the second term:
%    term2(i,p) = (1-y_enc(i,p))*(1-y_pred(i,p))
%
% In case of a single pattern, the Binary Cross-Entropy Loss simplify as:
% 
%    L(i) = -y_enc(i)*log(y_pred(i))  +   (1-y_enc(i))*(1-y_pred(i))
%
%---------------------------------------------------------------------------------------


end

function [cost] = L2_reg(lambda, W1, W2)
%compute l2 regularization cost
cost = (lambda/2) * (sum(sum(W1(:,2:end).^2)) + sum(sum(W2(:,2:end).^2)));
end

function [cost] = L1_reg(lambda, W1, W2)
%compute l2 regularization cost
cost = (lambda/2) * (sum(sum(abs(W1(:,2:end)))) + sum(sum(abs(W2(:,2:end)))));
end
