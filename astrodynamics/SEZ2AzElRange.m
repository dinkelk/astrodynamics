function [az,el,rho] = SEZ2AzElRange(R)
%
% Given the cartesian vector between the spacecraft and tracking station 
% in the SEZ frame, an azimuth, elevation, and range can be calculated 
% between the station and the spacecraft.
%
% Inputs: R   = SEZ spacecraft position vector relative to the ground
%               station. ie. R = R_sc - R_tracking_station
%
% Outputs:
%         az  = azimuth angle between ground station and spacecraft in
%               radians
%         el  = elevation angle between ground station and spacecraft in
%               radians
%         rho = range between ground station and spacecraft
%

% Calculate range:
rho = norm(R);
rhoSE = sqrt(R(1)^2 + R(2)^2);

% Calculate elevation:
sinEl = R(3)/rho;
cosEl = rhoSE/rho;
el = atan2(sinEl,cosEl);

% Calculate azimuth:
sinAz = R(2)/rhoSE;
cosAz = -R(1)/rhoSE;
az = atan2(sinAz,cosAz);

% Put azimuth in the range 0 to 2*pi:
if( az < 0 )
    az = az + 2*pi;
end

end