function [dV, TOF, theta, t_wait] = circular_rendezvous(a_tgt,a_int,thetai,k_int,mu)
%
% Description: Calculate the circular coplanar rendezvous of an interceptor
% leading a target by the phase angle theta.
%
% Inputs:
%
% Outputs:
%

% Calculate the orbital rotation rates:
w_tgt = sqrt(mu/a_tgt^3);
w_int = sqrt(mu/a_int^3);

% Calculate the semi-major axis of the phasing orbit
a = (a_tgt + a_int) / 2;

% Calculate the time of flight:
TOF = pi*sqrt(a^3/mu);

% Calculate the lead angle the target satellite must have for the transfer
% to take place:
alpha = w_tgt*TOF;

% Calculate the phasing angle for the target satellite:
theta = alpha - pi;

% Calculate the wait time fore the transfer based on the given thetai:
t_wait = (theta - thetai +2*pi*k_int) / (w_int - w_tgt);

% Calculate the velocities:
V_int = abs(sqrt(2*mu/a_int - mu/a) - sqrt(mu/a_int));
V_tgt = abs(sqrt(2*mu/a_tgt - mu/a) - sqrt(mu/a_tgt));

% Calculate the total dV:
dV = V_int + V_tgt;

end