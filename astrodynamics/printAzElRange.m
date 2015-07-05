function printAzElRange(az,el,rho)
fprintf(1,'azimuth   = %f deg\n',radtodeg(az));
fprintf(1,'elevation = %f deg\n',radtodeg(el));
fprintf(1,'range     = %f km\n',rho);
end