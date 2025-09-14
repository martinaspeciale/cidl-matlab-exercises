function [X,y,XX1,XX2,YY] = mog2D_gen(Npatterns, visualize)

if nargin < 1
    Npatterns = 100^2;    
end
if nargin < 2
    visualize = true;
end

x1 = linspace(-10,10,sqrt(Npatterns));
x2 = linspace(-10,10,sqrt(Npatterns));

[XX1,XX2] = meshgrid(x1,x2);

centre1 = -8;
centre2 = -1;
centre3 = +7;
ampl1 = 3;
ampl2 = -5;
ampl3 = 9;

espilon = 0.3;
k1 = ampl1 * exp(-((( XX1-centre1 ).*espilon).^2)).* exp(-((( XX2-centre1 ).*espilon).^2));
k2 = ampl2 * exp(-((( XX1-centre2 ).*espilon).^2)).* exp(-((( XX2-centre2 ).*espilon).^2));
k3 = ampl3 * exp(-((( XX1-centre3 ).*espilon).^2)).* exp(-((( XX2-centre3 ).*espilon).^2));

% YY = 10*( sin(XX1)./XX1 ) .* ( sin(XX2)./XX2 );

% YY = k1 + k2 + k3 -70;
YY = k1 + k2 + k3;

X = [ XX1(:), XX2(:) ];
y = YY(:);

if visualize
   figure('Name','Name mog2D synthetic dataset')
   surf(XX1,XX2,YY);
   title('sinc2D synthetic dataset. Domain: [-10,10]x[-10,10]');  
end
if nargout == 0
    clear X y XX1 XX2 YY
end
