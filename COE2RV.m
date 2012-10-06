function[RIJK,VIJK] = COE2RV(A,MU)
%  function[RIJK,VIJK] = COEstoRV(A)
%
%      R = [Ri, Rj, Rk] (radius vector)
%      V = [Vi, Vj, Vk] (velocity vector)
%
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
%

   %%% Parse out orbital elements %%%
   semi = A(1);
   e    = A(2);
   i    = A(3);
   node = A(4);
   arg  = A(5);
   true = A(6);
   
   p = semi*(1-e^2);  % p = semi-latus rectum (semiparameter)
   
   %%%  Position Coordinates in Perifocal Coordinate System
   RPQW(1) = p*cos(true) / (1+e*cos(true)); % x-coordinate (km)
   RPQW(2) = p*sin(true) / (1+e*cos(true)); % y-coordinate (km)
   RPQW(3) = 0;                             % z-coordinate (km)
   VPQW(1) = -sqrt(MU/p) * sin(true);       % velocity in x (km/s)
   VPQW(2) =  sqrt(MU/p) * (e+cos(true));   % velocity in y (km/s)
   VPQW(3) =  0;                            % velocity in z (km/s)
   
   %%%  Transformation Matrix (3 Rotations)  %%%
   rot = rot3(-node)*rot1(-i)*rot3(-arg);
   
   %%%  Transforming Perifocal -> xyz  %%%
   RIJK = rot*RPQW';
   VIJK = rot*VPQW';