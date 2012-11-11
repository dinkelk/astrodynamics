function V2 = gibbs(R1, R2, R3, mu) 
%   This function uses the Gibbs method of orbit determination to
%   to compute the velocity corresponding to the second of three
%   supplied position vectors.
%   mu            = gravitational parameter
%   R1, R2, R3    = three coplanar geocentric position vectors
%   r1, r2, r3    = the magnitudes of R1, R2 and R3
%   c12, c23, c31 = three independent cross products among
%                   R1, R2 and R3
%   N, D, S       = vectors formed from R1, R2 and R3 during
%                   the Gibbs' procedure
%   tol           = tolerance for determining if R1, R2 and R3
%                   are coplanar
%   V2            = the velocity corresponding to R2
%
tol = 1e-2; 

% Get position magnitudes:
r1 = norm(R1); 
r2 = norm(R2); 
r3 = norm(R3);

% Calculate cross products:
z12 = cross(R1,R2); 
z23 = cross(R2,R3); 
z31 = cross(R3,R1);

% Check that R1, R2 and R3 are not coplanar
if abs(dot(R1,z23)/r1/norm(z23)) > tol 
    error('Position vectors are not coplanar');
end

% Gibbs method:
N = r1*z23 + r2*z31 + r3*z12;
D = z12 + z23 + z31; 
S = R1*(r2 - r3) + R2*(r3 - r1) + R3*(r1 - r2);
B = cross(D,R2);
L = sqrt(mu/norm(N)/norm(D));

% Calculate the velocity at the time of the second position:
V2 = L*(B/r2 + S);

end