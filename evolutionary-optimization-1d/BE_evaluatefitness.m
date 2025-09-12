function fit = BE_evaluatefitness(f,P,a,b)
   fit = zeros(size(P,1),1);
   for i = 1:size(P,1)
       fit(i) = feval(f,logical2real(P(i,:),a,b));
   end
end
