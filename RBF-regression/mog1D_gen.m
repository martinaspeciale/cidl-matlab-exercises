function [X,y] = mog1D_gen(Npatterns, visualize)
% Mixture of Gaussian synthetic 1D dataset

if nargin < 1
    Npatterns = 200;    
end
if nargin < 2
    visualize = true;
end

X = linspace(-10,10,Npatterns)';

centre1 = -8;
centre2 = -1;
centre3 = +7;
ampl1 = 3;
ampl2 = -5;
ampl3 = 9;

espilon = 0.3;
k1 = ampl1 * exp(-((( X-centre1 ).*espilon).^2));
k2 = ampl2 * exp(-((( X-centre2 ).*espilon).^2));
k3 = ampl3 * exp(-((( X-centre3 ).*espilon).^2));

% y = k1 + k2 + k3 -70;
y = k1 + k2 + k3;


if visualize
   figure('Name','Name mog1D synthetic dataset')
   plot(X,k1,'ob',X,k2,'sr',X,k3,'^g',X,y,'.k');
   legend( sprintf('kernel 1 (centred in %d, amplitude %d)',centre1,ampl1), ...
           sprintf('kernel 2 (centred in %d, amplitude %d)',centre2,ampl2), ...
           sprintf('kernel 3 (centred in %d, amplitude %d)',centre3,ampl3), 'y', ...
           'Location', 'NorthWest', 'fontsize',16)
   
   title('mog1D synthetic dataset in 1D. Domain: [-10,10]');  
end

if nargout == 0
    clear X
    clear y
end

