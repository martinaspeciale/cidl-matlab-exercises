    % GA_RE_crossover_sbx_simplified - Simplified version of the Simulated Binary Crossover for Real Encoding
    %
    % Syntax:  [o1, o2] = GA_RE_crossover_sbx_simplified(p1, p2, lb, ub, eta, u)
    %
    % Inputs:
    %    p1     - Parent 1 chromosome (vector of real numbers)
    %    p2     - Parent 2 chromosome (vector of real numbers)
    %    lb     - Lower bounds for each gene (vector)
    %    ub     - Upper bounds for each gene (vector)
    %    eta    - Distribution index (non-negative scalar)
    %    u      - Random value, uniformly generated between 0 and 1
    %
    % Outputs:
    %    o1 - Offspring 1 chromosome (vector of real numbers)
    %    o2 - Offspring 2 chromosome (vector of real numbers)
    %
    % See also rand
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
    %  u = 0.3;
    % 
    %  % Perform SBX crossover
    %  [o1, o2] = GA_RE_crossover_sbx_simplified(p1, p2, lb, ub, eta, u);
    % 
    %  % Display results
    %  fprintf('Parent 1:    [ %s]\n', num2str(p1,'%.4f ')); % Parent 1:    [ 0.2000 0.5000 0.8000]
    %  fprintf('Parent 2:    [ %s]\n', num2str(p2,'%.4f ')); % Parent 2:    [ 0.6000 0.4000 0.3000]
    %  fprintf('Offspring 1: [ %s]\n', num2str(o1','%.4f ')); % Offspring 1: [ 0.2313 0.4922 0.7609] (expected)
    %  fprintf('Offspring 2: [ %s]\n', num2str(o2','%.4f ')); % Offspring 2: [ 0.5687 0.4078 0.3391] (expected)
    %
    %
    %  % % EXAMPLE 2
    %
    %  % Parent chromosomes (vectors of real numbers)
    %  p1 = [ 1.0, -0.6, -1.5,  0.5,  -1.0];
    %  p2 = [ 1.0,  0.7,  1.0,  -1.4, -1.0];
    % 
    %  % Lower and upper bounds for each gene
    %  lb = [-1.5, -1.5, -1.5, -1.5, -1.5];
    %  ub = [ 1.5,  1.5,  1.5,  1.5,  1.5];
    % 
    %  % Distribution index (non-negative parameter controlling the spread)
    %  eta = 2;
    % 
    %  % Generate a random value between 0 and 1
    %  u = 0.7;
    % 
    %  % Perform SBX crossover
    %  [o1, o2] = GA_RE_crossover_sbx_simplified(p1, p2, lb, ub, eta, u);
    % 
    %  % Display results
    %  fprintf('Parent 1:    [ %s]\n', num2str(p1,'%+.4f  '));  % [ +1.0000  -0.6000  -1.5000  +0.5000  -1.0000 ]
    %  fprintf('Parent 2:    [ %s]\n', num2str(p2,'%+.4f  '));  % [ +1.0000  +0.7000  +1.0000  -1.4000  -1.0000 ]
    %  fprintf('Offspring 1: [ %s]\n', num2str(o1','%+.4f  ')); % [ +1.0000  -0.7207  -1.5000  +0.6763  -1.0000 ]
    %  fprintf('Offspring 2: [ %s]\n', num2str(o2','%+.4f  ')); % [ +1.0000  +0.8207  +1.2320  -1.5000  -1.0000 ]

    % Authors: Marco Cococcioni, 2024-11-27

    function [o1, o2] = GA_RE_crossover_sbx_simplified(p1, p2, lb, ub, eta, u) % lb: lowerbound, ub: upperbound, eta: > 0
    % Ensure input vectors are column vectors
    p1 = p1(:);     p2 = p2(:);     lb = lb(:);     ub = ub(:);    
    % During debugging, pass to the function the vector u, for reproducibility    
    if nargin < 6,    u = rand(1,1);  end    
    % Calculate betaq
    if u <= 0.5
        betaq = (2*u)^(1.0 / (eta + 1));
    else
        betaq = (1/(2*(1-u)))^(1.0 / (eta + 1));
    end
    o1 = 0.5*( (1+betaq)*p1 + (1-betaq)*p2 );
    o2 = 0.5*( (1-betaq)*p1 + (1+betaq)*p2 );
    % Ensure offspring are within bounds
    o1 = min(max(o1, lb), ub);
    o2 = min(max(o2, lb), ub);
    % Small value to check for equality
    epsilon = 1e-14;
    % Handling identical parent genes
    indexes = abs(p1 - p2) < epsilon;
    o1(indexes) = p1(indexes);
    o2(indexes) = p1(indexes);
    end %end function

