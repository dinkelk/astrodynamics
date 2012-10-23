function H = groundsite3RangeHMat(x,xs,theta)
%
% Calculate the state-observation relation: drho/dXs
%

H = zeros(1,3);

% Constants:
s = sin(theta);
c = cos(theta);
rho = sqrt(norm(x) + norm(xs) - 2*(x(1)*xs(1) + x(2)*xs(2))*c ...
        + 2*(x(1)*xs(2) - x(2)*xs(1))*s - 2*x(3)*xs(3));

% Calculate drho/dR
H(1) = (xs(1) - x(1)*c - x(2)*s) / rho;
H(2) = (xs(2) - x(2)*c + x(1)*s) / rho;
H(3) = (xs(3) - x(3)) / rho;

end