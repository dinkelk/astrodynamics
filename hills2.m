function [R,V] = hills2(R0,V0,t,r,mu)
%
% Description: Solves Hill's equation (Clohessy-Wiltshire) assuming
% circular orbits. Given a delta velocity of spacecraft2 in the RTN
% (Radial-Transverse-Normal) frame relative to spacecraft 1, the position
% of spacecraft2 with respect to spacecraft1 after a given time is
% calculated.
%
% Inputs:  R0 = innitial relative position of spacecraft1 to spacecraft2
%          V  = relative delta velocity vector from spacecraft1 to spacecraft2 
%               in the RTN frame
%          t  = time after delta V is applied
%          r  = circular orbit radius
%          mu = gravitational parameter of central body
%
% Outputs: R  = the relative position of spacecraft2 with respect to
%               spacecraft1 after time t has passed after the maneuver V
%

% Find the angular rate of the spacecraft:
w = sqrt(mu/r^3);

% Save some calculations:
s = sin(w*t);
c = cos(w*t);

% Calculate each component of the final position:
R = zeros(3,1);
R(1) = V0(1)/w*s - (3*R0(1) + 2*V0(2)/w)*c + (4*R0(1) + 2*V0(2)/w);
R(2) = (6*R0(1) + 4*V0(2)/w)*s + 2*V0(1)/w*c - (6*w*R0(1) + 3*V0(2))*t + ...
    (R0(2) - 2*V0(1)/w);
R(3) = R0(3)*c + V0(3)/w*s;

% Calculate each component of the final velocity:
V = zeros(3,1);
V(1) = V0(1)*c + (3*w*R0(1) + 2*V0(2))*s;
V(2) = (6*w*R0(1) + 4*V0(2))*c - 2*V0(1)*s - (6*w*R0(1) + 3*V0(2));
V(3) = -R0(3)*w*s + V0(3)*c;

end