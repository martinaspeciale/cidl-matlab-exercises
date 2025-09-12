function real_value = logical2real(logicalVector,a,b)
%   real_value = logical2real(logicalVector,a,b)
%
%   % Example 1
%   real_value = logical2real(logical([1 1 0]),13,17)
%
%   % Example 2
%   len = 5;
%   real_value = logical2real(logical(round(rand(1,len))),-2.7,7.5)
%   real_value = logical2real(logical(round(rand(1,len))),-2.7,7.5)
%   real_value = logical2real(logical(round(rand(1,len))),-2.7,7.5)

    len = length(logicalVector);
    find(logicalVector);
    uint_value = sum(2.^(len-find(logicalVector))); % unsigned integer falling within {0,... 2^len-1}
    real_value_0_1 = uint_value/(2^len);            % this is a real number falling within the interval [0,1)
    real_value = a + real_value_0_1*(b-a) + 0.5*(b-a)/(2^len);  % this is a real number falling within the interval (a,b)  

end
