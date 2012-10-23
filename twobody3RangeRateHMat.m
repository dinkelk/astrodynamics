function H = twobody3RangeRateHMat(x,xs,theta, theta_dot)
%
% Calculate the state-observation relation: drho_dot/dX
%

H = zeros(2,6);

% Constants:
s = sin(theta);
c = cos(theta);
rho = sqrt(norm(x) + norm(xs) - 2*(x(1)*xs(1) + x(2)*xs(2))*c ...
        + 2*(x(1)*xs(2) - x(2)*xs(1))*s - 2*x(3)*xs(3));

rho_dot = ( dot(x(1:3),x(4:6)) - (x(4)*xs(1) + x(5)*xs(2))*c ...
                             + theta_dot*(x(1)*xs(1) + x(2)*xs(2))*s ...
                             +  (x(4)*xs(1) - x(5)*xs(2))*s ...
                             + theta_dot*(x(1)*xs(2) - x(2)*xs(1))*c ...
                             - x(6)*x(3) )...
                             / rho;

% Calculate drho_dt/dR
H(1) = (x(4) + theta_dot*xs(1)*s + theta_dot*xs(2)*c) / rho ...
     - (rho_dot*(x(1) - xs(1)*c + xs(2)*s)) / rho^2;
H(2) = (x(5) + theta_dot*xs(2)*s - theta_dot*xs(1)*c) / rho ...
     - (rho_dot*(x(2) - xs(2)*c - xs(1)*s)) / rho^2; 
H(3) = x(6)/rho - rho_dot*(x(3) - xs(3))/ rho^2;

% Calculate drho_dot/dV
H(4) = (x(1) - xs(1)*c + xs(2)*s) / rho;
H(5) = (x(2) - xs(2)*c - xs(1)*s) / rho;
H(6) = (x(3) - xs(3)) / rho;

end