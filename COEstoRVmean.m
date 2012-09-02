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

function[RIJK,VIJK] = COEstoRVmean(A,MU)

   semi = A(1);
   e    = A(2);
   i    = A(3);
   node = A(4);
   arg  = A(5);
   true = A(6);
   
   p = semi*(1-e^2);  % p = semi-latus rectum
   
   RPQW(1) = p*cos(true) / (1+e*cos(true));
   RPQW(2) = p*sin(true) / (1+e*cos(true));
   RPQW(3) = 0;

   VPQW(1) = -sqrt(MU/p) * sin(true);
   VPQW(2) =  sqrt(MU/p) * (e+cos(true));
   VPQW(3) =  0;
   
   rot = rot3(-node)*rot1(-i)*rot3(-arg);
   RIJK = rot*RPQW';
   VIJK = rot*VPQW';
   
   % RIJK = rot3(rot1(rot3(RPQW',-arg),-i),-node);
   % VIJK = rot3(rot1(rot3(VPQW',-arg),-i),-node);