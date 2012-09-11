function [dr] = twobody3J2Drag(t,r0,MU,J2,Re,D)
%
% Inputs:  t - time
%          r0 - positions and velocities in 3D of spacecraft
%        
%          r0 = [Xv0, Yv0, Zv0, Uv0, Vv0, Wv0, Xs0, Ys0, Zv0, Us0, Vs0, Ws0, Xp1_0, Yp1_0, etc...]'
%          MU  = [MUp]'
%          D = drag coefficient = C_D*(A/m)
%

% Innitialize:
dr = zeros(6,1); % Initialize derivative vector
   
% Integrate velocity to find position:
% X = int[dx/dt = U], Y = int[dy/dt = V]
dr(1:3) = r0(4:6);

% Integrate acceleration to find velocity:
r = norm(r0(1:3)); 
phi = asin(r0(3)/r);
dr(4) = -MU*r0(1)/r^3 * (1 - (3/2)*J2*(Re/r)^2*(5*r0(3)^2/r^2-1));
dr(5) = r0(2)/r0(1)*dr(4);
dr(6) = -MU*r0(3)/r^3 * (1 - (3/2)*J2*(Re/r)^2*(5*r0(3)^2/r^2-3));

% Add in drag terms:
H = 200; % km
rho0 = 4.0E-13; % kg/m^3
r_zero = 7298.145; % km
theta_dot = 7.29211585530066E-5; % rad/s

rho_A = rho0 * exp(-(r - r_zero)/H);
V_A = [r0(4) - theta_dot*r0(2); r0(5) - theta_dot*r0(1); r0(6)];
dr(4:6) = dr(4:6) + -0.5*D*rho_A*norm(V_A)*V_A;

end
