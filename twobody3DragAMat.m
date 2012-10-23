function A = twobody3DragAMat(x,MU,D)
%
% Calculate the partial derivatives matrix (A) of a given twobody state in
% 3-dimensions.
%
% Inputs: x = the state of the spacecraft [R;V]
%         D = drag coefficient = C_D*(A/m) in km^2/kg
%
% Output: A = the A matrix A(t) = dX_dot/dX (Partial-Derivatives Matrix)
%

% Get the 2-body A matrix:
A = twobody3AMat(x,MU);

% Get constants:
r = norm(x(1:3)); 
phi = asin(x(3)/r);
H = 200; % km
rho0 = 4.0E-4; % kg/km^3
r_zero = 7298.145; % km
theta_dot = 7.29211585530066E-5; % rad/s

rho_A = rho0 * exp(-(r - r_zero)/H);
V_A = [x(4) + theta_dot*x(2); x(5) - theta_dot*x(1); x(6)];

% Coefficients:
COEF1 = 0.5*D*rho_A*V_A;
COEF2 = 0.5*D*rho_A/V_A;
denom = r*H;

% Calculate dV_dot/dR:
du_dot_dx = COEF1 * x(1) * (x(4) + theta_dot*x(2)) / denom - ...
                COEF2 * (-theta_dot*x(5) + theta_dot^2*x(1)) * ...
                (x(4) + theta_dot*x(2));
du_dot_dy = COEF1 * x(2) * (x(4) + theta_dot*x(2)) / denom - ...
                COEF2 * (theta_dot*x(4) + theta_dot^2*x(2)) * ...
                (x(4) + theta_dot*x(2)) - COEF1*theta_dot;
du_dot_dz = COEF1 * x(3) * (x(4) + theta_dot*x(2)) / denom;

dv_dot_dx = COEF1 * x(1) * (x(5) + theta_dot*x(1)) / denom - ...
                COEF2 * (-theta_dot*x(5) + theta_dot^2*x(1)) * ...
                (x(5) - theta_dot*x(1)) + COEF1*theta_dot;
dv_dot_dy = COEF1 * x(2) * (x(5) + theta_dot*x(1)) / denom - ...
                COEF2 * (theta_dot*x(4) + theta_dot^2*x(2)) * ...
                (x(5) + theta_dot*x(1));
dv_dot_dz = COEF1 * x(3) * (x(5) + theta_dot*x(1)) / denom;

dw_dot_dx = COEF1 * x(6)*x(1) / denom - ... 
                COEF2 * x(6) * (theta_dot^2*x(1) - theta_dot*x(5));
dw_dot_dy = COEF1 * x(6)*x(2) / denom - ... 
                COEF2 * x(6) * (theta_dot^2*x(2) + theta_dot*x(4));
dw_dot_dz = COEF1 * x(3) * x(6) / denom;

dV_dot_dR = ...
[ du_dot_dx, du_dot_dy, du_dot_dz;
  dv_dot_dx, dv_dot_dy, dv_dot_dz;
  dw_dot_dx, dw_dot_dy, dw_dot_dz  ];

% Add drag:
A(4:6,1:3) = A(4:6,1:3) + dV_dot_dR;

% Calculate dV_dot/dV:
du_dot_du = -COEF2* (x(4) + theta_dot*x(2))^2 - COEF1;
du_dot_dv = -COEF2* (x(5) - theta_dot*x(1)) * (x(4) - theta_dot*x(2));
du_dot_dw = -COEF2* x(6) * (x(4) + theta_dot*x(2));

dv_dot_du = du_dot_dv;
dv_dot_dv = -COEF2* (x(5) + theta_dot*x(1))^2 - COEF1;
dv_dot_dw = -COEF2* x(6) * (x(5) - theta_dot*x(1));

dw_dot_du = du_dot_dw;
dw_dot_dv = dv_dot_dw;
dw_dot_dw = -COEF2 * x(6)^2 - COEF1;

dV_dot_dV = ...
[ du_dot_du, du_dot_dv, du_dot_dw;
  dv_dot_du, dv_dot_dv, dv_dot_dw;
  dw_dot_du, dw_dot_dv, dw_dot_dw  ];

% Add drag:
A(4:6,4:6) = A(4:6,4:6) + dV_dot_dV;

end