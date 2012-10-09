function [V] = hills(R,t,r,mu)
%
% Description: Solves Hill's equation (Clohessy-Wiltshire) assuming
% circular orbits. Given a position for spacecraft2 in the RTN
% (Radial-Transverse-Normal) frame relative to spacecraft 1, the deltaV
% required by spacecraft2 to rendezvous with spacecraft1 in a given time is
% calculated.
%
% Inputs:  R  = relative vector from spacecraft1 to spacecraft2 in the RTN 
%               frame
%          t  = desired rendezvous time
%          r  = circular orbit radius
%          mu = gravitational parameter of central body
%
% Outputs: V  = the deltaV required of spacecraft2 to rendezvous with
%               spacecraft 1 in time t
%

% Find the angular rate of the spacecraft:
w = sqrt(mu/r^3);

% Save some calculations:
s = sin(w*t);
c = cos(w*t);

% Calculate each component of the velocity
V = zeros(3,1);
V(2) = ((6*R(1)*(w*t-s)-R(2))*w*s - 2*w*R(1)*(4-3*c)*(1-c)) / ...
    ((4*s-3*w*t)*s + 4*(1-c)^2);
V(1) = -(w*R(1)*(4-3*c) + 2*(1-c)*V(2)) / ...
    s;
V(3) = -R(3)*w*c;

end