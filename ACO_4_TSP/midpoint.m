function [midpoint] = midpoint(n)
% Calculate the midpoint of each edge

M1 = average(n(1), n(2)); 
M2 = average(n(1), n(3));
M3 = average(n(1), n(4));
M4 = average(n(2), n(3)); 
M5 = average(n(2), n(5));
M6 = average(n(2), n(6));
M7 = average(n(3), n(4));
M8 = average(n(3), n(6));
M9 = average(n(3), n(7));
M10 = average(n(4), n(7));
M11 = average(n(4), n(8));
M12 = average(n(5), n(6));
M13 = average(n(5), n(9));
M14 = average(n(5), n(10));
M15 = average(n(6), n(7));
M16 = average(n(6), n(10));
M17 = average(n(6), n(11)); 
M18 = average(n(7), n(8));
M19 = average(n(7), n(11)); 
M20 = average(n(7), n(12));
M21 = average(n(8), n(12));
M22 = average(n(8), n(13));
M23 = average(n(9), n(10));
M24 = average(n(9), n(14));
M25 = average(n(10), n(11));
M26 = average(n(10), n(14));
M27 = average(n(10), n(15));
M28 = average(n(11), n(12));
M29 = average(n(11), n(15));
M30 = average(n(11), n(16));
M31 = average(n(12), n(13));
M32 = average(n(12), n(16)); 
M33 = average(n(12), n(17)); 
M34 = average(n(13), n(17));
M35 = average(n(14), n(15));
M36 = average(n(14), n(18));
M37 = average(n(15), n(16));
M38 = average(n(15), n(18));
M39 = average(n(15), n(19));
M40 = average(n(16), n(17));
M41 = average(n(16), n(19));
M42 = average(n(16), n(20));
M43 = average(n(17), n(20));
M44 = average(n(18), n(19));
M45 = average(n(18), n(21));
M46 = average(n(19), n(20));
M47 = average(n(19), n(21));
M48 = average(n(20), n(21));

midpoint = [M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, M15, M16, M17, M18, M19, M20, M21, M22, M23, M24, M25, M26, M27, M28, M29, M30, M31, M32, M33, M34, M35, M36, M37, M38, M39, M40, M41, M42, M43, M44, M45, M46, M47, M48];

end
