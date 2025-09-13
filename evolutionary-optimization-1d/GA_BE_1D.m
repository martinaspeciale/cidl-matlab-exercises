function [x_opt, f_opt, best_fit] = GA_BE_1D(f,a,b,generations,chrsize,popsize,pmutallgenes,displayAndPlot)
% Simplest Canonical Genetic Algorithm based on Binary Encoding
% for minimization of a real function in one dimension, 
% within the open interval (a,b).
% This version is elitist: the best individuals of the curret population
% are propagated in the next population.
%
% Parameters:
%   f is the handle to the function to optimise
%   a is the interval lowerbound
%   b is the interval upperbound
%   generations is the number of generations
%   chrsize is the length of the binary chromosome in the Binary Encoding
%      of the generic solution (the bigger, the higher will be the "resolution")
%   popsize is the size of the population
%   pmutallgenes is the probability to mutate each sigle gene of a chromosome
%
%
%   % Example 1 - Rastrigin
%   close all
%   f = @(x) 10 + x.^2 - 10*cos(2*pi*x);
%   a = -5;
%   b = 5;          
%   disp('Known optimum: x = 0.0 ( y = 0.0 )');
%   generations = 200;
%   chrsize = 10;
%   popsize = 10;
%   pmutallgenes = 0.10;
%   displayAndPlot = true;
%   [x_opt, f_opt] = GA_BE_1D(f,a,b,generations,chrsize,popsize,pmutallgenes,displayAndPlot)
%
%   % Example 2 - Sinusoidal shaped function
%   close all
%   f = @(x) sin(x) + sin((10.0 / 3.0) * x)
%   a = -2.7;
%   b = 7.5;
%   disp('known optimum: x = 5.145735 ( y = -1.8996 )');
%   generations = 200;
%   chrsize = 12;
%   popsize = 10;
%   pmutallgenes = 0.10;
%   displayAndPlot = true;
%   [x_opt, f_opt] = GA_BE_1D(f,a,b,generations,chrsize,popsize,pmutallgenes,displayAndPlot)

% Author: Marco Cococcioni, 2023

if mod(popsize,2) == 1
    error('popsize must be even.');
end
if nargin < 8
    displayAndPlot = false;
end

% Generate the initial population
P = BE_initpop(chrsize,popsize);  

% Computing the fitness of each individual in the initial population
fit_P = BE_evaluatefitness(f,P,a,b);
                  
% Initialise the vector with the best fitness four at each generation
best_fit = zeros(1,generations);  
best_fit(1) = min(fit_P);

for t = 2:generations
    % 1. Create the Mating Pool (MP) using binary tournment selection
    %    (the MP is of the the same size as P)
    MP = binarytournement(P,fit_P,popsize);

    % 2. Reshuffle the Mating Pool
    MP = MP(randperm(popsize),:);

    % 3. Apply the crossover operator to each pair in the MP, 
    %    to obtain the offspring population Q
    
    Q = false(popsize,chrsize);
    for i=1:2:popsize
       Q([i,i+1],:) = BE_XOVER_singlepoint(MP(i,:),MP(i+1,:));
    end    

    % 4. Apply mutation operator to obtain the mutated version of Q
    for i=1:popsize       
       Q(i,:) = BE_MUT_unifall(Q(i,:),pmutallgenes);              
    end

    % 5. Evaluate the fitness of Q
    fit_Q = BE_evaluatefitness(f,Q,a,b);    

    % 6. Compute R as the union of P and Q
    R = [P; Q];
    fit_R = [fit_P; fit_Q];

    % 7. Compute the new population P, by taking the best individuals from R
    [~,ind] = sort(fit_R,"ascend");
    new_P = R(ind(1:popsize),:);
    fit_new_P = fit_R(ind(1:popsize));

    % 8. Let the new population new_P become the current population 
    %    and do the same for the fitness
    P = new_P;
    fit_P = fit_new_P;

    % 9. Update best_fit
    [best_fit(t), ind] = min(fit_P);    
end

[f_opt, ind] = min(fit_P);
x_opt = logical2real(P(ind,:),a,b);

if displayAndPlot
   figure
   subplot(1,2,2)
   plot(1:generations,best_fit,'-b');
   set(gca,'xlim',[1,generations]);
   title('Best fitness found at each generation')
   ylim = get(gca,'ylim');

   subplot(1,2,1)
   first_gen = min(30,generations);
   plot(1:first_gen,best_fit(1:first_gen),'-b');
   set(gca,'xlim',[1,first_gen]);
   title(sprintf('Best fitness found during the first %d generations',first_gen))
   set(gca,'YLim',ylim);
end

end


