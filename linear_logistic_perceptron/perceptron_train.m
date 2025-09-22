function  w = perceptron_train(X,y,w_init,eta)
% Train of the perceptron, using the delta rule.
% See Probabilistic Machine Learning: An Introduction", by Kevin
% P. Murphy, Chapter 10 ("Logistic Regression").

w = w_init;
norm2 = 1e5; tol=1e-4;

while (norm2 > tol)
    w_old = w;
    for i=1:size(X,1)
        hat_y = Heaviside(X(i,:)*w);
        w = w - eta*(hat_y - y(i))*X(i,:)';        
    end
    norm2 = norm(w_old - w); % norm 2 of the difference of the two vectors
end
    
end

function a = Heaviside(x)
if x > 0
    a = 1;
else
    a = 0;
end
end
