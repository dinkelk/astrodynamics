function R = ECEF2ECI(r,theta_GST)
%
% Convert position vector in earth centered earth fixed to the earth centered
% innertial frame given the current Greenwich Sideral Time
%
% Inputs: R         = ECI vector
%         theta_GST = Greenwich sidereal time angle, in radians
%
% Outputs:
%         r         = the correspondung ECI vector
%

R = rot3(theta_GST)'*r;

end