function [X,y,XX1,XX2,YY] = sinc2D_gen(Npatterns)

if nargin < 1
    Npatterns = 100^2;    
end

x1 = linspace(-5,5,sqrt(Npatterns));
x2 = linspace(-5,5,sqrt(Npatterns));

[XX1,XX2] = meshgrid(x1,x2);

YY = 10*( sin(XX1)./XX1 ) .* ( sin(XX2)./XX2 );

X = [ XX1(:), XX2(:) ];
y = YY(:);

if nargout == 0
   figure('Name','Name sinc2D synthetic dataset')
   surf(XX1,XX2,YY);
   title('sinc2D synthetic dataset. Domain: [-5,5]x[-5,5]');  
end

