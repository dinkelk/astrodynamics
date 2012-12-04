function patchedconic(a1, a2, r1, r2, mu1, mu2, muS)
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
% Output: dV  = total deltaV of hohmann transfer from r1 to r2
%         TOF = total time of flight from orbit r1 to orbit r2
%
    % Calculate velocities of parking orbits:
    vp1 = sqrt(mu1/r1);
    vp2 = sqrt(mu2/r2);
    
    % Calculate hohmann between planets:
    [dV1, dV2, TOF] = hohmann(a1,a2,mu);
end