function [dr] = twobody3J2DragSTM(t,r0,MU,J2,Re,D)
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
dr(4) = -MU*r0(1)/r^3 * (1 - (3/2)*J2*(Re/r)^2*(5*r0(3)^2/r^2-1));
dr(5) = r0(2)/r0(1)*dr(4);
dr(6) = -MU*r0(3)/r^3 * (1 - (3/2)*J2*(Re/r)^2*(5*r0(3)^2/r^2-3));

% Add in drag terms:
[rho_A, V_A] = expDrag(r0);
dr(4:6) = dr(4:6) - 0.5*D*rho_A*norm(V_A)*V_A;

% Extract the current STM:
n = sqrt(numel(r0(7:end)));
phi = reshape(r0(7:end),n,n);

% Calculate the A matrix:
dx_dot_dx = twobody3J2DragAMat(r0(1:6),MU,J2,Re,D);
dx_dot_dJ = J2AMat(r0(1:6),MU,J2,Re);
dx_dot_dD = dragAMat(r0(1:6),D);

A = [ dx_dot_dx, dx_dot_dJ, dx_dot_dD;
      zeros(3,9) ];
      
phidot = A*phi;

% Put phidot back into state vector:
dr(7:end) = reshape(phidot,numel(phidot),1);

end
