function [] = printORBIT(O)
%  1    O = [a, (semi major axis)
%  2         e, (eccentricity)
%  3         i, (inclination)
%  4         node, (right ascension of ascending node)
%  5         arg, (argument of perigee)
%  6         true (true anomaly) 
%  7         P, (period)
%  8         E, (energy)
%  9         h, (momentum)
%  10        Rp, (radius of perigee)
%  11        Ra, (radius of apogee)
%            ]
fprintf(1,'a  = %f km\n',O(1));
fprintf(1,'e  = %f\n',O(2));
fprintf(1,'i  = %f deg\n',rad2deg(O(3)));
fprintf(1,'O  = %f deg\n',rad2deg(O(4)));
fprintf(1,'w  = %f deg\n',rad2deg(O(5)));
fprintf(1,'v  = %f deg\n',rad2deg(O(6)));
fprintf(1,'P  = %f s\n',O(7));
fprintf(1,'E  = %f km^2/s^2\n',O(8));
fprintf(1,'h  = %f km^2/s^2\n',O(9));
fprintf(1,'Rp = %f km\n',O(10));
fprintf(1,'Ra = %f km\n',O(11));