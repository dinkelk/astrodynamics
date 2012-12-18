function [dV, TOF] = orbit_rendezvous(a_tgt,theta,k_tgt,k_int,mu)
%
% Description: Calculate the circular coplanar rendezvous of an interceptor
% leading a target in the same circular orbit by the phase angle theta.
%
% Inputs:  a_tgt = semi-major axis of the target spacecraft
%          theta = angle of the interceptor in front of the target
%          k_tgt = number of orbits target revolves before rendezvous
%          k_int = number of orbits inteceptor revolves in transfer orbit
%                  before rendezvous
%          mu    = gravitational parameter of central body
%
% Outputs: dV    = total deltaV of maneuvers
%          TOF   = time of flight of transfer orbit
%

% Calculate the orbital rotation rates:
w = sqrt(mu/a_tgt^3);

% Calculate the transfer time:
TOF = (k_tgt*2*pi + theta) / w;

% Calculate the semi-major axis of the phasing orbit
a = (mu*(TOF/(k_int*2*pi))^2)^(1/3);

% Calculate the velocities:
Vphase = sqrt(2*mu/a_tgt - mu/a);
Vint = sqrt(mu/a_tgt);

% Calculate the total dV:
dV = 2*abs(Vphase - Vint);

end
