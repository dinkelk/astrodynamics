function A = twobody3J2AMat(x,MU,J2,Re)
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
JFAC = J2*(Re/r)^2;
ZFAC = (R(3)/r)^2;
DIAG = -MU/r^3 * (1 - 3/2*JFAC*(5*ZFAC - 1));
ZCOMP = 3*MU*R(3)/r^5 * (1 - 5/2*JFAC*(7*ZFAC-3));

du_dot_dy = 3*MU*R(1)*R(2)/r^5 * (1 - 5/2*JFAC*(7*ZFAC-1));
du_dot_dx = DIAG + R(1)/R(2)*du_dot_dy;
du_dot_dz = R(1)*ZCOMP;

dv_dot_dx = du_dot_dy;
dv_dot_dy = DIAG + R(2)/R(1)*dv_dot_dx;
dv_dot_dz = R(2)*ZCOMP;

dw_dot_dx = R(1)*ZCOMP;
dw_dot_dy = R(2)*ZCOMP;
dw_dot_dz = -MU/r^3 * (1 - 3/2*JFAC*(5*ZFAC - 1)) ...
    + 3*MU*R(3)^2/r^5 * (1 - 5/2*JFAC*(7*ZFAC-5));

dV_dot_dR = ...
[ du_dot_dx, du_dot_dy, du_dot_dz;
  dv_dot_dx, dv_dot_dy, dv_dot_dz;
  dw_dot_dx, dw_dot_dy, dw_dot_dz  ];

% Assemble the A matrix:
A = ...
[ dR_dot_dR, dR_dot_dV;
  dV_dot_dR, dV_dot_dV  ];

end