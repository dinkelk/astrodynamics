function [] = printTLE( TLE )
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]

str = '';
for ii = 1:length(TLE(1,:))
    str = sprintf('%s %s', str, TLE{1,ii});
end

str = sprintf('%s\n',str);
for ii = 1:length(TLE(2,:))
    str = sprintf('%s %s', str, TLE{2,ii});
end

fprintf(1,'%s\n',str);


