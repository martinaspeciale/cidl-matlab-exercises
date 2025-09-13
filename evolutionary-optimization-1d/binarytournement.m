function  MP = binarytournement(P,fit_P,popsize)
% Binary Tournment Selection for unconstrained problems.
%
   MP = false(popsize,size(P,2));
   for i=1:popsize
       ind = randperm(10,2); % this function randomly selects two parents from P
                             % then the one with the best fitness (the
                             % lower, when minimising) enters the mating
                             % pool MP
       if fit_P(ind(1)) < fit_P(ind(2)) 
           MP(i,:) = P(ind(1),:);
       else
           MP(i,:) = P(ind(2),:);
       end
   end
end    
