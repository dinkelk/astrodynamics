function R = AzElRange2SEZ(az,el,rho)
%
% Given the azimuth, elevation, and range from a tracking station to a
% spacecraft, the relative vector between the two can be calculated in the
% SEZ frame
%
% Inputs:
%         az   = azimuth angle between ground station and spacecraft in
%                radians
%         el   = elevation angle between ground station and spacecraft in
%                radians
%         rho  = range between ground station and spacecraft
%
% Outputs:
%         R  = SEZ spacecraft position vector relative to the ground
%              station. ie. R = R_sc - R_tracking_station
%

R = zeros(3,1);
R(1) = -rho*cos(el)*cos(az);
R(2) = rho*cos(el)*sin(az);
R(3) = rho*sin(el);

end