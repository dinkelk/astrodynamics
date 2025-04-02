function A = crtbp_derivatives(x,mu)
%
% This function returns the CRTBP partial derivative matrix, A, based on a
% nominal CRTBP state X and 3-body parameter mu.
%
% Define distances:
r1 = sqrt( (x(1) + mu)^2 + x(2)^2 + x(3)^2 );
r2 = sqrt( (x(1) -1 + mu)^2 + x(2)^2 + x(3)^2 );

J = [0 1 0; -1 0 0; 0 0 0];
omega = 1;

Uxx = 1 - (1-mu)/r1^3 - mu/r2^3 + 3*(1-mu)*(x(1) + mu)^2/r1^5 + 3*mu*(x(1)-1+mu)^2/r2^5;
Uyy = 1 - (1-mu)/r1^3 - mu/r2^3 + 3*(1-mu)* x(2)      ^2/r1^5 + 3*mu* x(2)      ^2/r2^5;
Uzz =     (1-mu)/r1^3 - mu/r2^3 + 3*(1-mu)* x(3)      ^2/r1^5 + 3*mu* x(3)      ^2/r2^5;
Uxy = 3*(1-mu)*(x(1)+mu)*x(2)/r1^5 + 3*mu*(x(1)-1+mu)*x(2)/r2^5;
Uyx = Uxy;
Uxz = 3*(1-mu)*(x(1)+mu)*x(3)/r1^5 + 3*mu*(x(1)-1+mu)*x(3)/r2^5;
Uzx = Uxz;
Uyz = 3*(1-mu)* x(2)    *x(3)/r1^5 + 3*mu* x(2)      *x(3)/r2^5;
Uzy = Uyz;

Vrr = [Uxx Uxy Uxz; Uyx Uyy Uyz; Uzx Uzy Uzz];

A = [zeros(3), eye(3); Vrr, 2*omega*J];

end
