function [dt] = propagate2body2(A0,dNu,mu)
% function [dt] = propagate2body(A0,A,mu)
%
% Given an initial COE and a delta true anomaly, the delta time between the 
% two states is returned.
%
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
%
%   Inputs: A0 = Innitial COE
%           dt = time to propagate
%           mu = central body gravitational parameter
%
%   Outputs: A = Final COE
%

% Calculations for A0:
% Find eccentric anomaly:
cosE = (A0(2) + cos(A0(6)))/(1 + A0(2)*cos(A0(6)));
sinE = (sin(A0(6))*sqrt(1 - A0(2)^2))/(1 + A0(2)*cos(A0(6)));
E = atan2(sinE,cosE);
if(E < 0)
    E = 2*pi + E;
elseif( E > 2*pi )
    E = E - 2*piE;
end

% Calculate mean anomaly:
M = E - A0(2)*sin(E);

% Calculate time since perigee:
n = sqrt(mu/A0(1)^3);
t0 = (M/n);

% Calculations for A:
A = A0; 
A(6) = A(6) + dNu;

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
t = (M/n);

% Calculate the time difference:
P = 2*pi/n;
dt = t - t0;

if( dt < 0 )
    dt = dt + P;
end

end

function E = M2E(M,e)
    kep = @(E)(E - e*sin(E) - M);
    E = fzero(kep,M+e*sin(M));
end
