% Interpolation vs Approximation
%
% This script shows the difference between interpolation
% and approximation.


% Step 1: Generating ten points {x_i, y_i}
x = (-4:1:5)'; % ten input points
y = 1./(1+x.^2) + 0.05*randn(10,1);

% Step 2: Obtain the unique polynomial function of degree 9
%         that passes through the given points

P = vander(x)\y;

% Step 3: Guessing a better model, which approximate the given data
xev = linspace(-5,5,1000)';
yev = polyval(P,xev);
ytrue = 1./(1+xev.^2); % here we are trying the function 1/(1+x*x)

figure
plot(x,y,'ko',xev,yev,'r-.',xev,ytrue,'g-','linewidth',3,'markersize',8)
legend('Data points (10 points)','Interpolating polynomial of degree 9','A better model, which approximates, not interpolate (y = 1./(1+x.*x))','fontsize',20)
grid on
% title('Runge example')
title('Interpolation vs Approximation','fontsize',20)
set(gca,'xlim',[-4.23, 5])
