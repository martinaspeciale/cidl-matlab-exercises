function str = polydisp(polcoeff)
% POLYDISP - This function displays a polynomial function.
% 
% Input: the coefficients of the polynomial function,
%        provided in the following order: first the coefficient
%        of the highest power, then those of lower power.
%
% See also: polyval, polyvalm, polyfit.
%
%   % Example
%   pol = [ 1 3.4, 4 2 ]  % x^3 + 3.4*x^2 + 4*x + 1
%   polydisp(pol);

% Author: Marco Cococcioni, 2023

if all(polcoeff == 0)
    s = '0';
    str = s;
    return
else
    d = length(polcoeff) - 1;
    s = cell(1,d);
    ind = 1;
    for a = polcoeff
        if a ~= 0
            if ind ~= 1
                if a > 0
                    s(ind) = {' + '};
                    ind = ind + 1;
                else
                    s(ind) = {' - '};
                    a = -a;
                    ind = ind + 1;
                end
            end
            if a ~= 1 || d == 0
                if a == -1
                    s(ind) = {'-'};
                    ind = ind + 1;
                else
                    s(ind) = {num2str(a)};
                    ind = ind + 1;
                    if d > 0
                        s(ind) = {'*'};
                        ind = ind + 1;
                    end
                end
            end
            if d >= 2
                s(ind) = {['x^' int2str(d)]};
                ind = ind + 1;
            elseif d == 1
                s(ind) = {'x'};
                ind = ind + 1;
            end
        end
        d = d - 1;
    end
end
str = [s{:}];

if nargout == 0
    disp(str);
end
end

