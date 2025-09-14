    % GA_RE_crossover_sbx_advanced - Simulated Binary Crossover for Real Encoding
    %
    % Syntax:  [o1, o2] = GA_RE_crossover_sbx_advanced(p1, p2, lb, ub, eta, u)
    %
    % Inputs:
    %    p1     - Parent 1 chromosome (vector of real numbers)
    %    p2     - Parent 2 chromosome (vector of real numbers)
    %    lb     - Lower bounds for each gene (vector)
    %    ub     - Upper bounds for each gene (vector)
    %    eta    - Distribution index (non-negative scalar)
    %    u      - Random values between 0 and 1 (vector of same length as p1 and p2)
    %
    % Outputs:
    %    o1 - Offspring 1 chromosome (vector of real numbers)
    %    o2 - Offspring 2 chromosome (vector of real numbers)
    %
    % See also rand
    %
    %
    %  % % EXAMPLE 1
    %
    %  % Parent chromosomes (vectors of real numbers)
    %  p1 = [0.2, 0.5, 0.8];
    %  p2 = [0.6, 0.4, 0.3];
    % 
    %  % Lower and upper bounds for each gene
    %  lb = [0.0, 0.0, 0.0];
    %  ub = [1.0, 1.0, 1.0];
    % 
    %  % Distribution index (non-negative parameter controlling the spread)
    %  eta = 2;
    % 
    %  % Generate a random value between 0 and 1
    %  u = [0.3, 0.7, 0.1];
    % 
    %  % Perform SBX crossover
    %  [o1, o2] = GA_RE_crossover_sbx_advanced(p1, p2, lb, ub, eta, u);
    % 
    %  % Display results
    %  fprintf('Parent 1:    [ %s]\n', num2str(p1,'%.4f ')); % Parent 1:    [ 0.2000 0.5000 0.8000]
    %  fprintf('Parent 2:    [ %s]\n', num2str(p2,'%.4f ')); % Parent 2:    [ 0.6000 0.4000 0.3000]
    %  fprintf('Offspring 1: [ %s]\n', num2str(o1,'%.4f ')); % Offspring 1: [ 0.2349 0.5093 0.4061] (typical)
    %  fprintf('Offspring 2: [ %s]\n', num2str(o2,'%.4f ')); % Offspring 2: [ 0.5676 0.3908 0.6919] (typical)
    %
    %
    %  % % EXAMPLE 2
    %
    %  % Parent chromosomes (vectors of real numbers)
    %  p1 = randn(1,5);
    %  p2 = randn(1,5);
    % 
    %  % Lower and upper bounds for each gene
    %  lb = [-1.5, -1.5, -1.5, -1.5, -1.5];
    %  ub = [ 1.5,  1.5,  1.5,  1.5,  1.5];
    % 
    %  % Distribution index (non-negative parameter controlling the spread)
    %  eta = 2;
    % 
    %  % Generate a random value between 0 and 1
    %  u = [0.3, 0.7, 0.1, .2, .8];
    % 
    %  % Perform SBX crossover
    %  [o1, o2] = GA_RE_crossover_sbx_advanced(p1, p2, lb, ub, eta, u);
    % 
    %  % Display results
    %  fprintf('Parent 1:    [ %s]\n', num2str(p1,'%+.4f  '));
    %  fprintf('Parent 2:    [ %s]\n', num2str(p2,'%+.4f  '));
    %  fprintf('Offspring 1: [ %s]\n', num2str(o1','%+.4f  '));
    %  fprintf('Offspring 2: [ %s]\n', num2str(o2','%+.4f  '));    


    % Authors: Marco Cococcioni, 2024-11-27

    function [o1, o2] = GA_RE_crossover_sbx_advanced(p1, p2, lb, ub, eta, u) % lb: lowerbound, ub: upperbound, eta: > 0
    % Ensure input vectors are column vectors
    p1 = p1(:);     p2 = p2(:);     lb = lb(:);     ub = ub(:);    
    % Number of genes
    n = length(p1);
    % During debugging, pass to the function the vector u, for reproducibility    
    if nargin < 6,    u = rand(n,1);  else  u = u(:); end
    % Initialise offspring ( this kind of init. is useful when p1(i) == p2(i) )
    o1 = p1; o2 = p2;
    % Small value to check for equality
    epsilon = 1e-14;
    for i = 1:n
        if abs(p1(i) - p2(i)) > epsilon
            % Order p1 and p2
            if p1(i) < p2(i)
                x_min = p1(i);    x_max = p2(i);
            else
                x_min = p2(i);    x_max = p1(i);
            end
            % Calculate beta
            beta = 1.0 + (2.0 * (x_min - lb(i)) / (x_max - x_min));
            alpha = 2.0 - beta^(-(eta + 1));
            if u(i) <= 1.0 / alpha
                betaq = (u(i) * alpha)^(1.0 / (eta + 1));
            else
                betaq = (1.0 / (2.0 - u(i) * alpha))^(1.0 / (eta + 1));
            end
            c1 = 0.5 * ((x_min + x_max) - betaq * (x_max - x_min));
            % Calculate beta
            beta = 1.0 + (2.0 * (ub(i) - x_max) / (x_max - x_min));
            alpha = 2.0 - beta^(-(eta + 1));
            if u(i) <= 1.0 / alpha
                betaq = (u(i) * alpha)^(1.0 / (eta + 1));
            else
                betaq = (1.0 / (2.0 - u(i) * alpha))^(1.0 / (eta + 1));
            end
            c2 = 0.5 * ((x_min + x_max) + betaq * (x_max - x_min));
            % Ensure offspring are within bounds
            c1 = min(max(c1, lb(i)), ub(i));
            c2 = min(max(c2, lb(i)), ub(i));
            % Assign offspring values
            if rand() <= 0.5
                o1(i) = c2;    o2(i) = c1;
            else
                o1(i) = c1;    o2(i) = c2;
            end        
        end % enf if
    end % enf for
