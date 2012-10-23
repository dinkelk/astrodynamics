function A = dragAMat(x,D)
%
% Calculate the partial derivatives matrix (A): [dX_dot/dC_D]
%

% Get constants:
r = norm(x(1:3)); 
%phi = asin(x(3)/r);
H = 88667.0; % m
rho0 = 3.614E-13; % kg/m^3
r_zero = 7078136.3; % m
theta_dot = 7.29211585530066E-5; % rad/s

rho_A = rho0 * exp(-(r - r_zero)/H);
V_A = [x(4) + theta_dot*x(2); x(5) - theta_dot*x(1); x(6)];

% HACK THIS IS PROB WRONG:
V_A = norm(V_A);

% Coefficients:
COEF1 = 0.5*D*rho_A*V_A;
%COEF2 = 0.5*D*rho_A/V_A;
%denom = r*H;

A = zeros(6,1);

% Calculate dV_dot/dC_D:
A(4) = -COEF1*(x(4) + theta_dot*x(2));
A(5) = -COEF1*(x(5) - theta_dot*x(1));
A(6) = -COEF1*x(6);

end