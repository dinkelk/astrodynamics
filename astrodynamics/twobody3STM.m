function [dr] = twobody3STM(t,r0,MU)
%
% Inputs:  t - time
%          r0 - positions and velocities and STM in 3D of spacecraft
%

% Innitialize:
dr = zeros(length(r0),1); % Initialize derivative vector
   
% Integrate velocity to find position:
% X = int[dx/dt = U], Y = int[dy/dt = V]
dr(1:3) = r0(4:6);

% Integrate acceleration to find velocity:
r = norm(r0(1:3)); 
dr(4:6) = -MU*r0(1:3)/r^3;

% Extract the current STM:
phi = reshape(r0(7:end),6,length(r0(7:end))/6);

% Calculate the A matrix:
A = twobody3AMat(r0(1:6),MU);
phidot = A*phi;

% Put phidot back into state vector:
dr(7:end) = reshape(phidot,numel(phidot),1);

end
