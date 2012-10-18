function [A] = RV2COE(R, V, MU)
% function[A] = RVtoCOEs(R, V, MU)
% Inputs:
%      R  = [Ri, Rj, Rk] (radius vector)
%      V  = [Vi, Vj, Vk] (velocity vector)
%      MU = Gravitational Parameter
%
% Outputs:
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
% Note: All angles are given in radians

r = norm(R);
energy=norm(V)^2/2 - MU/r;
a = -MU/2/energy;

H = cross(R,V);
H = H(:);
E = cross(V,H)/MU - R/r;
e = norm(E);
inclination = acos(H(3)/norm(H));

if abs(inclination)<1e-5
    node = 0;
    if e==0 %circular equatorial
        arg = NaN;
        true = R(1)/r;
        if R(2)<0
            true = 2*pi - true;
        end
    else %elliptical equatorial
        arg = acos(E(1)/e);
        if E(2)<0
            arg = 2*pi - arg;
        end
        true = acos(dot(E,R)/e/r); %true anomaly
        if dot(R,V) < 0
            true = 2*pi - true; 
        end
    end
else
    k = [0,0,1];
    N = cross(k,H);
    
    node = acos(N(1)/norm(N));
    if N(2)<0
        node=2*pi-node;
    end
    
    arg = acos(  dot(N,E) / ( norm(N)*norm(E) )  );
    if E(3)<0
        arg = 2*pi - arg;
    end
end


true = acos(dot(E,R)/(norm(E)*norm(R)));
if dot(R,V)<0
    true = 2*pi - true;
end


A = [a; e; inclination; node; arg; true];