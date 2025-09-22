% Script minimumOfASixticPolinomialUsingGD.m

% This function shows how to minimise a polynomial function
% using gradient descent.
%
% The gradient is computed using Matlab builtin function polyder.

% Marco Cococcioni, 15 October 2023

%% Crear all
close all
clc
clear

%% Parameters
eta = 0.0005;
num_iters = 1000;
num_iter_to_display = 50;

%% Minimise a 6-degree polynomial ('sixtic polynomial) function
% $$ P(x) = \frac{1}{10} (x^6 -4x^5 -26x^4 +56x^3 + 253x^2 + 20x -300) $$
% using Gradient Descent.
%
% All of its six roots are real numbers:  [-3, -2, -2, 1, 5, 5]
%

% ans = 1
% conv(ans,[1 3])   % adds the root -3
% conv(ans,[1 2])   % adds the root -2
% conv(ans,[1 2])   % adds the root -2
% conv(ans,[1 -1])  % adds the root 1
% conv(ans,[1 -5])  % adds the root 5
% conv(ans,[1 -5])  % adds the root 5
%
% Now ans is equal to [ 1    -4   -26    56   253    20  -300]
     
% https://www.youtube.com/watch?app=desktop&v=Y5S9eIBh0GA

sixtic_pol = 1/10 * [1    -4   -26    56   253    20  -300]; 

% NB: In Matlab a polynomial function is modeled by
% a vector of coefficients. Then polyval allows to evaluate
% the polynomial function on a specific point (or vector of points)

m = 1000;
x = linspace(-7,8.5,m);
y = polyval(sixtic_pol, x);
figure('name','Sixtic polynomial function')
plot(x,y,'linewidth',2)
grid on
title('Sixtic polynomial function')

figure('name','Same polynomial function, zoomed in');
plot(x,y,'linewidth',2)
grid on
set(gca,'xlim',[-6,8]);
set(gca,'ylim',[-50,140]);
title('Same polynomial function, zoomed in');

abscissa_arrow = annotation(gcf,'arrow',[0.21875 0.861607142857143],...
    [0.324 0.323809523809524]);
ordinate_arrow = annotation(gcf,'arrow',[0.464285714285714 0.463392857142857],...
    [0.184714285714286 0.886904761904762]);
drawnow

%% let us now compute the first derivative (i.e., the gradient)

grad = polyder(sixtic_pol);
figure
plot(x,y,'linewidth',2)
grid on
set(gca,'nextplot','add');
plot(x, polyval(grad,x),'-r','linewidth',2)
legend('Sixtic polynomial function','Its derivative (gradient)','fontname','times','fontsize',24);
set(gca,'xlim',[-5.5814    7.2100],'ylim',[-650.015 1015.517]);

%% Roots of the gradient (position of relative minima/maxima)
% [ -2.70349253  -2  -0.04007195  3.07689781  5 ]
location_of_local_minima_and_maxima = roots(grad);
  
%% In particular, the location of the absolute minimum is located in x = -0.04007195
% where the function values y = -30.03988514

x0 = -6; % will converge to x = -2.70349253 (the first local minimum from the left)
[x_his, pol_his] = minimization_using_GD(sixtic_pol, x0, grad, eta, num_iters);
displayIterations(x_his, pol_his, num_iter_to_display,x0);


x0 = +8; % will converge to x = +5 (the first local minimum from the right)
[x_his, pol_his] = minimization_using_GD(sixtic_pol, x0, grad, eta, num_iters);
displayIterations(x_his, pol_his, num_iter_to_display,x0);


x0 = +2; % will converge to x = -0.00 (tre true absolute minimum)
[x_his, pol_his] = minimization_using_GD(sixtic_pol, x0, grad, eta, num_iters);
displayIterations(x_his, pol_his, num_iter_to_display,x0);

function [x_history, pol_history] = minimization_using_GD(pol, x0, grad, eta, num_iters)

% Initialize x_history and pol_history
x_history = zeros(num_iters+1, 1);   % history of x values
x_history(1) = x0;
pol_history = zeros(num_iters+1, 1); % history of values of the polynomial function evaluated at x values
pol_history(1) = polyval(pol, x0);

old_x = x0;
% Gradient descent loop
for k = 1:num_iters
    new_x = old_x - eta * polyval(grad,old_x);
    old_x = new_x;
    x_history(k+1) = new_x;
    pol_history(k+1) = polyval(pol, new_x);
end
end

function displayIterations(x_his, pol_his, num_iter_to_display, x0)
fprintf('\n\nDisplaying the first %d and the latest %d iterations\nwhen starting from x0=%g\n',num_iter_to_display, num_iter_to_display, x0);
for i=1:num_iter_to_display+1
    fprintf('it:%3d  x:%5.5f  pol(x):%5.5f\n',i-1, x_his(i), pol_his(i));
end
fprintf('...\n');
for i=length(x_his)-num_iter_to_display+1:length(x_his)
    fprintf('it:%4d  x:%5.5f  pol(x):%5.5f\n',i-1, x_his(i), pol_his(i));
end
end
