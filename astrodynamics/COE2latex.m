function [] = COE2latex(A)
%      A = [a, (semi major axis)
%           e, (eccentricity)
%           i, (inclination)
%           node, (right ascension of ascending node)
%           arg, (argument of perigee)
%           true (true anomaly) ]
fprintf('\\begin{align*}\n');
fprintf(1,'a &= %f \\ km \\\\ \n',A(1));
fprintf(1,'e &= %f \\\\ \n',A(2));
fprintf(1,'i &= %f^\\circ \\\\ \n',rad2deg(A(3)));
fprintf(1,'\\Omega &= %f^\\circ \\\\ \n',rad2deg(A(4)));
fprintf(1,'\\omega &= %f^\\circ \\\\ \n',rad2deg(A(5)));
fprintf(1,'\\nu &= %f^\\circ \n',rad2deg(A(6)));
fprintf('\\end{align*}\n');


