function A = MeeustoCOE(E)
%
% Input:
%      E = [L, (mean longitude of the planet)
%           a, (semimajor axis of the orbit)
%           e, (eccentricity of the orbit
%           i, (inclination of the orbit)
%           Omega, (longitude of the ascending node)
%           Pi (longitude of perihelion)
%
% Output:
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]

% Convert to radians:
E(1) = deg2rad(E(1));
E(4) = deg2rad(E(4));
E(5) = deg2rad(E(5));
E(6) = deg2rad(E(6));

AU = 1.49597870691e8;
A(1) = E(2) * AU;
A(2) = E(3);
A(3) = E(4);
A(4) = E(5);
A(5) = E(6) - E(5);

M = E(1) - E(6);
Ccen = (2*E(3) - E(3)^3/4 + 5*E(3)^5/96)*sin(M)...
     + (5*E(3)^2/4 -11*E(3)^4/24)*sin(2*M)...
     + (13*E(3)^3/12 - 43*E(3)^5/64)*sin(3*M)...
     + 102*E(3)^4/96*sin(4*M)...
     + 1097*E(3)^5/960*sin(5*M);
A(6) = M + Ccen;

end