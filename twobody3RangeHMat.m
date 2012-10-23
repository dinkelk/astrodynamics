function H = twobody3RangeHMat(x,xs,theta)
%
% Calculate the state-observation relation: drho/dX
%

H = zeros(2,6);

% Constants:
s = sin(theta);
c = cos(theta);
rho = sqrt(norm(x) + norm(xs) - 2*(x(1)*xs(1) + x(2)*xs(2))*c ...
        + 2*(x(1)*xs(2) - x(2)*xs(1))*s - 2*x(3)*xs(3));

% Calculate drho/dR
H(1) = (x(1) - xs(1)*c + xs(2)*s) / rho;
H(2) = (x(2) - xs(2)*c - xs(1)*s) / rho;
H(3) = (x(3) - xs(3)) / rho;

% Calculate drho/dV
% zeros... 

end