function [model,W1,W2] = MLP_MSELIN_train(P, y, model)
%learn weights from training data

[W1, W2] = MLP_initialize_weights(model);

eta = model.eta;

epochs = model.epochs;
minibatches = model.minibatches;  

% % Additional parameters (for advanced mode)
% alpha = model.alpha;
% decrease_const = model.decrease_const;
% l1 = model.l1;
% l2 = model.l2;

delta_W1_prev = zeros(size(W1));
delta_W2_prev = zeros(size(W2));

model.cost = Inf;

for e=1:epochs    
    
    % % advanced version: adaptive learning rate
    % eta = eta / (1+decrease_const*e);
              
    I = reshape(1:length(y),minibatches,[]);
                  
    for m=1:minibatches
        
        idx = I(m,:);
        
        %feedforward
        [rA2,A1,A0,rZ1] = MLP_MSELIN_forward(P(idx,:), W1, W2);              

        cost = MLP_MSE_cost(y(idx), rA2, model, W1, W2);
        model.cost = [model.cost, cost];        
        
        fprintf('Epoch %d/%d, minibatch %04d, Loss (MSE) %g\n', e, epochs, m, cost);

        %compute gradient via backpropagation
        [delta_W1_unscaled, delta_W2_unscaled] = MLP_MSELIN_backprop(rA2,A1,A0,rZ1,y(idx)',W1,W2); %,l1,l2);
        
        delta_W1 = eta * delta_W1_unscaled;
        delta_W2 = eta * delta_W2_unscaled;

        W1 = W1 - delta_W1;
        W2 = W2 - delta_W2;        

        % % advanced version
        % W1 = W1 - (delta_W1 + (alpha * delta_W1_prev));
        % W2 = W2 - (delta_W2 + (alpha * delta_W2_prev));                
        % delta_W1_prev = delta_W1;
        % delta_W2_prev = delta_W2;
        
    end
    
end

model.W1 = W1;
model.W2 = W2;

end


function [delta_W1_unscaled, delta_W2_unscaled] = MLP_MSELIN_backprop(rA2,A1,A0,rZ1,Y,W1,W2) %,l1,l2) 
% Compute the partial derivative of the loss with respect to the two weighting matrices W2 and W1,
% using the backpropagation algorithm.

% rA2 is 1xB
% A1  is (H+1)xB
% A0  is (D+1)xB
% rZ1 is HxB 
% y   is 1xB
% W1  is Hx(D+1)
% W2  is 1x(H+1)

% Step 1: compute dL_dZ2 of size 1xB                % NB: rA2 coincides with y_pred
dL_dZ2 = rA2-Y;                                     % NB: dL_dZ2 could be called "grad2", the gradient on the output layer with respect the pre-activation Z2


% Step 2: compute dL_dW2 % size 1x(H+1)
dL_dW2 = dL_dZ2*A1';                                % NB: dL_dW2 could be called "delta_W2_unscaled", because it is of the same size of W2 and stores the unscaled variation


% Step 3: compute dL_dA1 of size (H+1)xB 
dL_dA1 = W2'*dL_dZ2; 


% Step 4: compute dL_drZ1 of size HxB (also sigma_prime_of_rZ1 has size HxB)
sigma_prime_of_rZ1 = MLP_sigmoid_derivative(rZ1);
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


% -----------------------------------------------------------------------------
% NB: grad2 is the gradient at the hidden layer.
% It is a column vector in the case of a single pattern 
% (minibatch equal to the training set site) or a matrix,
% to be imagined, in the latter case, a matrix of columns, 
% the gradients of each input pattern in the minibatch.
%
% NB: grad1 is the gradient at the hidden layer (derivative 
% of the loss with respect Z1, the pre-activation at the hidden layer).
% It is a column vector in the case of a single pattern 
% (minibatch equal to the training set site) or a matrix,
% to be imagined, in the latter case, a matrix of columns, 
% the gradients of each input pattern in the minibatch.
% -----------------------------------------------------------------------------

end

function [cost] = MLP_MSE_cost(y, y_pred, model, W1, W2)
%compute cost function



cost = sum((y'-y_pred).*(y'-y_pred))/(2*length(y)); % cost is a scalar value, even when minibatch size is greather than one

% % Advanced version (the one with L1 and/or L2 regularisation)
% l1 = model.l1;
% l2 = model.l2;
% L1_term = L1_reg(l1,W1,W2);
% L2_term = L2_reg(l2,W1,W2);
% cost = cost + L1_term + L2_term;

end

function [cost] = L2_reg(lambda, W1, W2)
%compute L2 regularization cost
cost = (lambda/2) * (sum(sum(W1(:,2:end).^2)) + sum(sum(W2(:,2:end).^2)));
end

function [cost] = L1_reg(lambda, W1, W2)
%compute L1 regularization cost
cost = (lambda/2) * (sum(sum(abs(W1(:,2:end)))) + sum(sum(abs(W2(:,2:end)))));
end
