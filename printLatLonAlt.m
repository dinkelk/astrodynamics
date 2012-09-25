function printLatLonAlt(lat,lon,alt)
fprintf(1,'latitude  = %f deg\n',radtodeg(lat));
fprintf(1,'longitude = %f deg\n',radtodeg(lon));
fprintf(1,'altitude  = %f km\n',alt);
end