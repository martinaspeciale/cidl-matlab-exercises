function initpop = BE_initpop(ngenes,popsize)

if nargin < 1
    popsize = 1;
end

initpop = logical(round(rand(popsize,ngenes)));
