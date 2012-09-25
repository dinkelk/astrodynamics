function R = geocentric2ECEF(lat,lon,h)
%
% Convert a set of geocentric coordinates (lat,lon,r) to an ECEF position
%
% Inputs: lat = latitude in radians
%         lon = longitude in radians
%         h   = altitude above a spherical (geocentric) earth 
%
% Outputs:
%         R   = the corresponding ECEF vector
%

% Define the spherical radius of the earth for geocentric coordinates:
Re = 6378; % km 

% Calculate radius:
r = h + Re;

% Calculate the ECEF vector:
R = zeros(3,1);
R(1) = r*cos(lat)*cos(lon);
R(2) = r*cos(lat)*sin(lon);
R(3) = r*sin(lat);

end