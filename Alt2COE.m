function A = Alt2COE(ha,hp,Re)
%
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
%

% Calculate radius of perigee and apogee:
ra = ha + Re;
rp = hp + Re;

% Calculate orbit parameters:
A(1) = (ra + rp) * 0.5;
A(2) = (ra - rp) / (ra + rp);
A(3) = 0;
A(4) = 0;
A(5) = 0;
A(6) = 0;

end
