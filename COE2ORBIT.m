function O = COE2ORBIT(A,mu)
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
O = A;
O(10) = O(1)*(1-O(2));
O(11) = O(10)*(1+O(2))/(1-O(2));
O(8) = -mu/(2*O(1));
O(9) = sqrt(mu*O(10)*(1+O(2)));
O(7) = ((2*pi)/(mu^2))*(O(9)/(sqrt(1-O(2)^2)))^3;



