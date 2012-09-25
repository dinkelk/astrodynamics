function [lat,lon,h] = ECEF2geocentric(R)
%
% Convert a set of geocentric coordinates (lat,lon,r) to an ECEF position
%
% Inputs:  
%         R   = the ECEF vector
%
% Outputs:       
%         lat = latitude in radians
%         lon = longitude in radians
%         h   = altitude above a spherical (geocentric) earth
%

% Define the spherical radius of the earth for geocentric coordinates:
Re = 6378; % km 

% Calculate height:
r = norm(R);
h = r - Re;

% Calculate latitude:
lat = asin(R(3)/r);

% Calculate longitude:
cosLon = R(1)/(r*cos(lat));
sinLon = R(2)/(r*cos(lat));
lon = atan2(sinLon,cosLon);
if( lon < 0 )
    lon = lon + 2*pi;
end


end