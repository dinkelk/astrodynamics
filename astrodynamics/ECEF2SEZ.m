function R = ECEF2SEZ(r,lat,lon)
%
% Given a vector in the ECEF frame as well as the SEZ origin (tracking station)
% latitude and longitude on the Earth, the SEZ vector can be calculated.
%
% Inputs: 
%         r   = Position vector in the ECEF frame
% Outputs:
%         R   = Position vector in the SEZ frame
%         lat = Latitude of SEZ origin (tracking station lat)
%         lon = Longitude of SEZ origin (tracking station lon)
%

R = rot2(pi/2 - lat)*rot3(lon)*r;

end