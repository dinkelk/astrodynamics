function r = ECI2ECEF(R,theta_GST)
%
% Convert position vector in earth centered innertial frame to the earth centered
% earth fixed frame given the current Greenwich Sideral Time
%
% Inputs: r         = ECI vector
%         theta_GST = Greenwich sidereal time angle, in radians
%
% Outputs:
%         R         = the corresponding ECEF vector
%

r = rot3(theta_GST)*R;

end