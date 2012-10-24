function rho = range(R,Rs,theta)
%
% Calculate the range from a groundsite in ECEF to a satellite in ECEF.
%

% Constants:
s = sin(theta);
c = cos(theta);

% Calculate range
rho = sqrt(norm(R) + norm(Rs) - 2*(R(1)*Rs(1) + R(2)*Rs(2))*c ...
        + 2*(R(1)*Rs(2) - R(2)*Rs(1))*s - 2*R(3)*Rs(3));
    
end