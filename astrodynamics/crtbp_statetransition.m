function ydot=crtbp_statetransition(t,y,mu)
%
% This function is to be used with ODE45 to integrate the state transition
% matrix and the s/c state using the CRTB equations of motion.
%

% Define the number of state parameters:
n = 6;

% Extract the s/c state and the STM:
x0 = y(1:n)';
phi = reshape(y(n+1:end),n,n);

% Get the jacobian A matrix:
A = crtbp_derivatives(x0,mu);

% Integrate the STM:
dphi = A * phi;

% Reshape the state transition matrix:
dphi = reshape(dphi,numel(dphi),1);

% Calculate the CRTB derivatives:
dx = crtbp(t,x0,mu);

% Evaluate EOM:
ydot = [dx; dphi];
