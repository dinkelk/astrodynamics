function [A,t1,t2] = propagate2body(A0,dt,mu)
%
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
%

A = A0;

% Find eccentric anomaly:
cosE = (A(2) + cos(A(6)))/(1 + A(2)*cos(A(6)));
sinE = (sin(A(6))*sqrt(1 - A(2)^2))/(1 + A(2)*cos(A(6)));
E = atan2(sinE,cosE);
if(E < 0)
    E = 2*pi + E;
elseif( E > 2*pi )
    E = E - 2*piE;
end

% Calculate mean anomaly:
M = E - A(2)*sin(E);

% Calculate time since perigee:
n = sqrt(mu/A(1)^3);
P = 2*pi/n;
t = (M/n);

% Calculate new time:
t = t + dt;
if(t < 0)
    t = P + t;
elseif(t > P)
    t = t - P;
end

% Calculate new mean anomaly:
M = n*t;

% Calculate new eccentric anomaly:
E = M2E(M,A(2));

% Calculate new true anomaly:
cosTheta = (cos(E) - A(2))/(1 - A(2)*cos(E));
sinTheta = (sin(E)*sqrt(1-A(2)^2))/(1 - A(2)*cos(E));
A(6) = atan2(sinTheta,cosTheta);
if(A(6) < 0)
    A(6) = 2*pi + A(6);
elseif( A(6) > 2*pi )
    A(6) = A(6) - 2*pi;
end

end

function E = M2E(M,e)
    kep = @(E)(E - e*sin(E) - M);
    E = fzero(kep,M+e*sin(M));
end
