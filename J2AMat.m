function A = J2AMat(x,MU,J2,Re)
%
% Calculate the partial derivatives matrix (A): [dX_dot/dmu, dX_dot/dJ2]
%

% Extract position, velocity, and distance:
R = x(1:3);
r = norm(R);

% Calculate dV_dot/dR:
JFAC = J2*(Re/r)^2;
ZFAC = (R(3)/r)^2;
DIAG = -1/r^3 * (1 - 3/2*JFAC*(5*ZFAC - 1));
%ZCOMP = 3*MU*R(3)/r^5 * (1 - 5/2*JFAC*(7*ZFAC-3));

A = zeros(6,2);

% Calculate dV_dot/dmu:
A(4,1) = DIAG * x(1);
A(5,1) = DIAG * x(2);
A(6,1) = -1/r^3 * (1 - 3/2*JFAC*(5*ZFAC - 3)) * x(3);

% Calculate dV_dot/dJ2:
A(4,2) = 3/2 * MU * x(1) / r^3 * ZFAC * (5*ZFAC-1);
A(5,2) = 3/2 * MU * x(2) / r^3 * ZFAC * (5*ZFAC-1);
A(6,2) = 3/2 * MU * x(3) / r^3 * ZFAC * (5*ZFAC-3);

end