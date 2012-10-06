function [A, JD] = TLE2COE( TLE, mu )
% Inputs:
%      TLE = 2 row cell string. Each entry containing a TLE parameter
%      MU = Gravitational Parameter
%
% Outputs:
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]

A = zeros(6,1);

% Get mean motion:
n = str2double(TLE{2,8}) * 2 * pi / 86400;

% Calculate a:
A(1) = (mu/n^2)^(1/3);

% Extract the other COEs:
A(2) = str2double(['0.',TLE{2,5}]);
A(3) = degtorad(str2double(TLE{2,3}));
A(4) = degtorad(str2double(TLE{2,4}));
A(5) = degtorad(str2double(TLE{2,6}));

% Get mean anomaly:
M = degtorad(str2double(TLE{2,7}));
E = M2E(M,A(2));

% Calculate true anomaly:
cosTheta = (cos(E) - A(2))/(1 - A(2)*cos(E));
sinTheta = (sin(E)*sqrt(1-A(2)^2))/(1 - A(2)*cos(E));
A(6) = atan2(sinTheta,cosTheta);
if(A(6) < 0)
    A(6) = 2*pi + A(6);
elseif( A(6) > 2*pi )
    A(6) = A(6) - 2*pi;
end

% Extract the time:
time = TLE{1,4};
if(str2double(time(1:2)) > 60)
    year = str2double(['19',time(1:2)]);
else
    year = str2double(['20',time(1:2)]);
end

dayofyear = str2double(time(3:5));
fracofday = str2double(['0',time(6:end)]);

% Convert to Julian Date
[year, month, day, hour, minute, second] = dayofyear2date(dayofyear,year);
JD = date2jd(year, month, day, hour, minute, second) + fracofday;

end

function E = M2E(M,e)
    kep = @(E)(E - e*sin(E) - M);
    E = fzero(kep,M+e*sin(M));
end