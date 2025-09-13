function [offsprings, splitpoint] = BE_XOVER_singlepoint(parent1, parent2)
% This function computes the single point crossover
% between two parents. It gererates two offsprings.
% The first row of offspring output variable is the first child,
% while the second row of offspring output variable is the second child.
%
% The second output (splitpoint) is useful only for debugbing purposes.
%
% % Example 1
%   parent1 = logical([1   1   1   1   1   1   1   1   1   1])
%   parent2 = logical([0   0   0   0   0   0   0   0   0   0])
%   [offsprings, splitpoint] = BE_XOVER_singlepoint(parent1, parent2);
%   fprintf('Point of split: %d\n', splitpoint');
%   disp(offsprings)
%
% % Example 2
%   parent1 = logical(round(rand(1,10)))
%   parent2 = logical(round(rand(1,10)))
%   [offsprings, splitpoint] = BE_XOVER_singlepoint(parent1, parent2);
%   fprintf('Point of split: %d\n', splitpoint');
%   disp(offsprings)

   len = length(parent1);
   splitpoint = randperm(len-2,1)+1;
   offsprings = false(2,len);

   offsprings(1,1:splitpoint) = parent1(1:splitpoint);
   offsprings(1,splitpoint+1:end) = parent2(splitpoint+1:end);

   offsprings(2,1:splitpoint) = parent2(1:splitpoint);
   offsprings(2,splitpoint+1:end) = parent1(splitpoint+1:end);
end
