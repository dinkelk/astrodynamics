function dx = crtbp(t,x0,mu)
%
% Circular Restricted Three-body Problem (Equations of Motion):
%          For use with a variable step integrator...
%
% Input: x0 - innitial state vector [x0,y0,z0,xdot0,ydot0,zdot0]
%
% Output: dx - next state vector [xdot,ydot,zdot,xdotdot,ydotdot,zdotdot]
%

% Initialize Derivative Vector:
dx = zeros(6,1);

% Define distances:
r1 = sqrt( (x0(1) + mu)^2 + x0(2)^2 + x0(3)^2 );
r2 = sqrt( (x0(1) -1 + mu)^2 + x0(2)^2 + x0(3)^2 );

% Integrate: dx/dt = xdot
dx(1:3) = x0(4:6);

% Integrate: dx^2/dt^2 = EOM
C1 = (1-mu)/r1^3;
C2 = mu/r2^3;
dx(4) =  2*x0(5) + x0(1) - C1*(x0(1) + mu) - C2*(x0(1) - 1 + mu);
dx(5) = -2*x0(4) + x0(2) - C1*x0(2)        - C2* x0(2)          ;
dx(6) =                  - C1*x0(3)        - C2* x0(3)          ;

end
