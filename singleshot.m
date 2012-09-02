function x = singleshot(x0,mu)
%
% Circular Restricted Three-body Problem (Equations of Motion)
% Single Shooting Method. An innitial condition for the halo orbit x0
% is refined until a periodic initial condition is reached. This new
% initial condition is returned to the user.
%
% Input: x0 - innitial state vector guess for halo orbit [x0,0,z0,0,ydot0,0]
%
% Output: x - final (periodic) state vector for halo orbit
%

% Tolerance for detecting periodic orbit:
% tolxzdot = 10E-8;
tolxzdot = 1e-13;

% Use an event to integrate to T/2:
options = odeset('Events',@detecthalforbit,'RelTol',1e-13,'AbsTol',1e-13);

% Allocate space for state vector and state transition matrix:
y0 = zeros(42,1);
phi = zeros(6);
cnt = 0;

while(1)
    % Initialize the 6x6 state transition matrix to the identity matrix.
    % STM(t0,tf) = I if t0 = tf:
    phi0 = eye(6);
    
    % Put the entries into our long state vector (36 for stm + 6 for
    % spacecraft 3-body state = length 42):
    for i=1:6
        for j=1:6;
            y0(6*(i-1)+j)=phi0(i,j);
        end
    end
    y0(end-5:end) = x0;
    
    % Integrate to spacecraft state and state transition matrix to
    % the nth x-axis crossing, using event function (y = 0) SHOOT!!:
    [t,y] = ode45(@crtbp_statetransition,[0 Inf],y0,options,mu);
        
    % Extract final state spacecraft state from big state vector:
    x = y(end,end-5:end);
    
    % Check to see if orbit is periodic
    % @ T/2 (x-axis crossing) is xdot < tol & z-dot < tol
    if( (abs(x(4)) < tolxzdot) && (abs(x(6)) < tolxzdot) )
        break;
    end
    
    % Extract the STM from the state vector:
    for i=1:6
        for j=1:6;
            phi(i,j)=y(end,6*(i-1)+j);
        end
    end 
    
    % We need xdotdot and zdotdot before we can do any corrections, call
    % our differential at the last timestep:
    y_tmp = crtbp_statetransition(t(end),y(end,:),mu);
    
    % Extract xdotdot and zdotdot:
    x_tmp = y_tmp(end-5:end);
    xdotdot = x_tmp(4);
    zdotdot = x_tmp(6);

    % Compute changes to innitial condition using the state transition matrix,
    % Correct the worst component first:
    %if(x(6) > x(4)) % zdot is bigger than xdot, so correct z and ydot first
    
        % z0 & ydot update (keep x0 fixed):
        M = [phi(4,3) phi(4,5); phi(6,3) phi(6,5)] - 1/x(5) * [xdotdot; zdotdot] * [phi(2,3) phi(2,5)];
        % Solve with negated xdot and zdot because we only integrated to
        % T/2:
        dzdydot0 = M\[-x(4); -x(6)];
        
        % Correct innitial conditions and shoot again:
        x0 = x0 + [0; 0; dzdydot0(1); 0; dzdydot0(2); 0];
    
    %else            % xdot is bigger than zdot, so correct x and ydot first
            
        % x0 & ydot update (keep z0 fixed):
%         M = [phi(4,1) phi(4,5); phi(6,1) phi(6,5)] - 1/x(5) * [xdotdot; zdotdot] * [phi(2,1) phi(2,5)];
%         % Solve with negated xdot and zdot because we only integrated to
%         % T/2:
%         dxdydot0 = M\[-x(4); -x(6)];
%         
%         % Correct innitial conditions and shoot again:
%         x0 = x0 + [dxdydot0(1); 0; 0; 0; dxdydot0(2); 0];
%     end
    
    cnt = cnt+1;
end

% Store final value:
x = x0;

end

function [value,isterminal,direction] = detecthalforbit(t,x,mu)
    % toly = 1E-13;
    state = x(end-5:end);    % extract spacecraft state from state vector
    value = state(2);        % when y = 0
    isterminal = 1;          % stop the integration
    direction = 0;           % from either direction
end
    