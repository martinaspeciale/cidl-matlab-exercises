%% --- linearLeastSquaresUsingGD ---


%%
% The error in predicting the i-th pattern is defined as: 
%
% $$E_i = \frac{1}{2}(y_i - \hat{y}_i)^2 $$

%% 
% When using a linear model, we have that:
%
% $$ \hat{y}_i = x_i \cdot w + b $$

%%
% Therefore: 
%
% $$E_i = \frac{1}{2}(y_i - \hat{y}_i)^2 = \frac{1}{2}(y_i - (x_i \cdot w + b))^2 $$

%%
% The derivative of $E_i$ with respect to $b$ is:
%
% $$ \frac{\delta E_i}{\delta b} = (y_i - (x_i \cdot w + b))$$

%% 
% while the derivative of $E_i$ with respect to $w^j$ is
%
% $$\frac{\delta E_i}{\delta w^j} = (y_i - (x_i \cdot w + b)) \cdot x^j_i $$

%% Clearing everything
close all
clear
clc

% Generate random data
n = 1;      % number of inputs
m = 100;    % number of observations
eta = 0.01;
num_iters = 100;
noise_level = 0.1;

% Deciding the true w
X = rand(m, n);
w_true = [1:n+1]';
w_sign = (-ones(n+1,1)).^w_true;
w_true = w_true.*w_sign;
disp(w_true');

% Computing the 'true' y
A = [ ones(m,1), X ];
y = A*w_true + noise_level*randn(m, 1);

% Fit an hyperplane over the data
[w, b, E_history] = LLS_by_GD(X, y, eta, num_iters);

% Plot the data and the hyperplane
switch n
    case 1
        plot(X(:, 1), X * w + b,'or');
    case 2
        error TBC
    otherwise
        error TBC
end


% Print the weights and bias
fprintf('w = %s\n', w);
fprintf('b = %s\n', b);

% % Print the cost function values
% for i = 1:num_iters
%     fprintf('E(%d) = %g\n', i, E_history(i));
% end

% Draw the Error along the iterations
figure('name','Error along the iterations')
plot(1:num_iters, E_history);


function [w, b, avg_E_at_each_iteration] = LLS_by_GD(X, y, eta, num_iters)

[N, D] = size(X);

% Initialize w and b
w = zeros(D, 1); % column vector
b = 0;

% Initialize E_history
avg_E_at_each_iteration = zeros(num_iters, 1);

% Gradient descent loop
for k = 1:num_iters
    E = zeros(1,N);
    for i = 1:N
        y_pred = X(i,:)*w + b;
        
        residual = y_pred - y(i);
        E(i) = 0.5*residual^2;
        
        % % Compute gradients
        % gradient_w = (1 / (num_points)) * sum(residual .* X(j,:));
        % gradient_b = (1 / (num_points)) * sum(residual);
        
        gradient_w = residual .* X(i,:);
        gradient_b = residual;
        
        % Update parameters
        w = w - eta * gradient_w;
        b = b - eta * gradient_b;
        w_pred = [b, w];
        disp(w_pred');
    end
    avg_E_at_each_iteration(k) = sum(E)/N; % average error
end

end
