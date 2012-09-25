function r = SEZ2ECEF(R,lat,lon)
%
% Given a vector in the SEZ frame as well as the SEZ origin (tracking station)
% latitude and longitude on the Earth, the ECEF vector can be calculated.
%
% Inputs: R   = Position vector in the SEZ frame
%         lat = Latitude of SEZ origin (tracking station lat)
%         lon = Longitude of SEZ origin (tracking station lon)
%
% Outputs:
%         r   = Position vector in the ECEF frame
%

r = (rot2(pi/2 - lat)*rot3(lon))'*R;

end