function [dr] = twobody3J2(t,r0,MU,J2,Re)
%
% Inputs:  t - time
%          r0 - positions and velocities in 3D of spacecraft
%        
%          r0 = [Xv0, Yv0, Zv0, Uv0, Vv0, Wv0, Xs0, Ys0, Zv0, Us0, Vs0, Ws0, Xp1_0, Yp1_0, etc...]'
%          MU  = [MUp]'
%

% Innitialize:
dr = zeros(6,1); % Initialize derivative vector
   
% Integrate velocity to find position:
% X = int[dx/dt = U], Y = int[dy/dt = V]
dr(1:3) = r0(4:6);

% Integrate accleration to find velocity:
r = norm(r0(1:3));
phi = asin(r0(3)/r);
dr(4) = -MU*r0(1)/r^3 * (1 - (3/2)*J2*(Re/r)^2*(5*r0(3)^2/r^2-1));
dr(5) = r0(2)/r0(1)*dr(4);
dr(6) = -MU*r0(3)/r^3 * (1 - (3/2)*J2*(Re/r)^2*(5*r0(3)^2/r^2-3));


end
