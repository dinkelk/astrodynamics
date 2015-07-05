function [] = printCOE(A)
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
fprintf(1,'a = %f km\n',A(1));
fprintf(1,'e = %f\n',A(2));
fprintf(1,'i = %f deg\n',rad2deg(A(3)));
fprintf(1,'O = %f deg\n',rad2deg(A(4)));
fprintf(1,'w = %f deg\n',rad2deg(A(5)));
fprintf(1,'v = %f deg\n',rad2deg(A(6)));


