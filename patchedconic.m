function [dv1,dv2,TOF] = patchedconic(a1, a2, r1, r2, mu1, mu2, muS)
%
% Description: Assuming circular planetary orbits of radius a1 and a2
% around a central body described by muS, with circular parking orbits at
% planet1 of r1 and at planet 2 of r2, calculate a patched conics
% trajectory from planet 1 to planet 2.
%
% Input:  a1  = radius of planet 1
%         a2  = radius of planet 2
%         r1  = parking orbit at planet 1
%         r2  = parking orbit at planet 2
%         mu1 = gravitational parameter of planet 1
%         mu2 = gravitational parameter of planet 2
%         muS = gravitational parameter of central body (sun)
%
% Output: dv1,dv2  = deltav required at planet 1 and planet 2 respectively
%         TOF = total time of flight of hohmann between
%

    % Calculate the velocities at each planetary orbit:
    v1 = sqrt(muS/a1);
    v2 = sqrt(muS/a2);
    
    % Calculated the semi-major axis of the transfer orbit:
    a = (a1+a2)/2;
    
    % Calculate the velocities of the transfer orbit:
    v1t = sqrt(2*muS/a1 - muS/a);
    v2t = sqrt(2*muS/a2 - muS/a);
    
    % Calculate the V infinity at both planets:
    vinf1 = abs(v1t - v1);
    vinf2 = abs(v2t - v2);
    
    % Calculate velocities of parking orbits:
    vp1 = sqrt(mu1/r1);
    vp2 = sqrt(mu2/r2);
    
    % Calculate the hyperbolic velocity needed to escape/arrive at planets:
    vh1 = sqrt(2*mu1/r1 + vinf1^2);
    vh2 = sqrt(2*mu2/r2 + vinf2^2);
    
    % Calculate the deltaVs:
    dv1 = abs(vh1 - vp1);
    dv2 = abs(vh2 - vp2);
    
    % Calculate the total deltaV and TOF:
    TOF = pi*sqrt(a^3/muS);
end