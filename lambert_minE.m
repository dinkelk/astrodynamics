function [V0,dt,a,e,p] = lambert_minE(R0,Rf,mu)

% Get the position magnitudes:
r0 = norm(R0);
rf = norm(Rf);

% Use the law of cosines to solve for the chord:
cosdV = dot(R0,Rf)/(r0*rf);
c = sqrt(r0^2 + rf^2 - 2*r0*rf*cosdV);

% Solve for the semiperimeter:
s = (r0 + rf + c)/2;

% Solve for beta_e:
Be = asin(2*sqrt((s-c)/s));

% Solve for the minimum p:
p = 2/c*(s - r0)*(s - rf);

% Solve for the eccentricity:
e = sqrt(1 - 2*p/s);

% Solve for the minimum semi-major axis:
a = s/2;

% Solve for the minimum time:
dt = sqrt(a^3/mu)*(pi - Be + sin(Be));

% Solve for the initial velocity:
sindV =  dt*sqrt(1-cosdV^2);
V0 = sqrt(mu*p)/(r0*rf*sindV) * (Rf - (1 - rf/p*(1-cosdV)*R0));

end
