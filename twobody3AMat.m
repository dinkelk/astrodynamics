function A = twobody3AMat(x,MU)
%
% Calculate the partial derivatives matrix (A) of a given twobody state in
% 3-dimensions.
%
% Inputs: x = the state of the spacecraft [R;V]
%
% Output: A = the A matrix A(t) = dX_dot/dX (Partial-Derivatives Matrix)
%

% Extract position, velocity, and distance:
R = x(1:3);
% V = x(4:6);
r = norm(R);

% Allocate space for matrix parts:
dR_dot_dR = zeros(3);
dR_dot_dV = eye(3);
% dV_dot_dR = zeros(3);
dV_dot_dV = zeros(3);

% Calculate dV_dot/dR:
du_dot_dx = -MU*(-2*R(1)^2 + R(2)^2 + R(3)^2)/r^5;
du_dot_dy = 3*MU*R(1)*R(2)/r^5;
du_dot_dz = 3*MU*R(1)*R(3)/r^5;

dv_dot_dx = du_dot_dy;
dv_dot_dy = -MU*(R(1)^2 - 2*R(2)^2 + R(3)^2)/r^5;
dv_dot_dz = 3*MU*R(2)*R(3)/r^5;

dw_dot_dx = du_dot_dz;
dw_dot_dy = dv_dot_dz;
dw_dot_dz = -MU*(R(1)^2 + R(2)^2 - 2*R(3)^2)/r^5;

dV_dot_dR = ...
[ du_dot_dx, du_dot_dy, du_dot_dz;
  dv_dot_dx, dv_dot_dy, dv_dot_dz;
  dw_dot_dx, dw_dot_dy, dw_dot_dz  ];

% Assemble the A matrix:
A = ...
[ dR_dot_dR, dR_dot_dV;
  dV_dot_dR, dV_dot_dV  ];

end