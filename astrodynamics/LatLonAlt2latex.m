function [] = LatLonAlt2latex(lat,lon,alt)
fprintf('\\begin{align*}\n');
fprintf(1,'\\phi &= %f^\\circ \\\\ \n',radtodeg(lat));
fprintf(1,'\\lambda &= %f^\\circ \\\\ \n',radtodeg(lon));
fprintf(1,'h &= %f \\ km \\\\ \n',alt);
fprintf('\\end{align*}\n');


