function [rho,rho_dot] = rangerate(R,V,Rs,theta,thetad)
%
% Calculate the range from a groundsite in ECEF to a satellite in ECEF.
%

% Constants:
s = sin(theta);
c = cos(theta);

% Calculate range
rho = sqrt(dot(R,R) + dot(Rs,Rs) - 2*(R(1)*Rs(1) + R(2)*Rs(2))*c ...
        + 2*(R(1)*Rs(2) - R(2)*Rs(1))*s - 2*R(3)*Rs(3));

% Calculate range rate:
rho_dot = ( dot(R,V) - (V(1)*Rs(1) + V(2)*Rs(2))*c ...
                     + thetad*(R(1)*Rs(1) + R(2)*Rs(2))*s ...
                     + (V(1)*Rs(2) - V(2)*Rs(1))*s ...
                     + thetad*(R(1)*Rs(2) - R(2)*Rs(1))*c ...
                     - V(3)*Rs(3) )...
                     / rho;
end
