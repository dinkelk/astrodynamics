function R = AzElRangeRate2SEZRate(az,el,rho,az_dot,el_dot,rho_dot)
%
% Given the azimuth, elevation, and range and rates from a tracking station 
% to a spacecraft, the velocity vector can be calculated in the SEZ frame
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
R(1) = -rho_dot*cos(el)*cos(az) + rho*sin(el)*cos(az)*el_dot ...
            + rho*cos(el)*sin(az)*az_dot;
R(2) = rho_dot*cos(el)*sin(az) - rho*sin(el)*sin(az)*el_dot + ...
            rho*cos(el)*cos(az)*az_dot;
R(3) = rho_dot*sin(el) + rho*cos(el)*el_dot;

end