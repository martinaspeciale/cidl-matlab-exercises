function mutated_x = BE_MUT_unif_all(logical_x,mutprob)
% BE_MUT_unif_all - Uniform mutation of potentially all genes 
%
% This is a mutating function for binary encoded chromosome.
% It (potentially) flips all genes, with the same probability, mutprob.
%
% % Example 1
% logical_x = logical([1 0 0 0 1 1 1 0]);
% mutprob = 0.5;
% mutated_x = BE_MUT_unif_all(logical_x,mutprob)
%
% % Example 2
% logical_x = logical(ones(1,10));
% mutprob = 0.2;
% mutated_x = BE_MUT_unif_all(logical_x,mutprob)

len = length(logical_x);
prob = rand(1,len);
ind_of_genes_to_mutate = find(prob < mutprob); % indexes of the genes to flip

mutated_x = logical_x;
mutated_x(ind_of_genes_to_mutate) = logical(1-logical_x(ind_of_genes_to_mutate));


