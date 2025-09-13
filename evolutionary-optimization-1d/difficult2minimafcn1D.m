function y = difficult2minimafcn1D(x)
% Function with two minima, in 1D, where the global minimum
% is rather difficult to find.
%
% Its mathematical description is the followin(in latex)
% 
%  
% $$ f\left(x\right)\left\lbrace \begin{array}{ll} e^{\frac{x}{100}}  & x\le
% 100\\ 
% -e^{-1} +\left(x-100\right)\left(x-102\right) & x>100
% \end{array}\right.$$ 
%
%
% % Example of usage
% a = -10;
% b = 103;
% x = linspace(a,b,200); 
% y = difficult2minimafcn1D(x);
% plot(x,y)
% set(gca,'XLim', [a, b]);
% set(gca,'XTick', round(linspace(a,b,10)));

% Author: Marco Cococioni, 2023 (function taken from Matlab demo
% GlobalVsLocalOptimizationusingGaExample.mlx)

y = zeros(size(x));
ind_le100 = find(x <= 100);
y(ind_le100) = -exp(-(x(ind_le100)/100).^2);
ind_gt100 = find(x > 100);
y(ind_gt100) = -exp(-1) + (x(ind_gt100)-100).*(x(ind_gt100)-102);


