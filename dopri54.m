function [t, x] = dopri54( FUNC, tspan, x0, h0, rtol, varargin)

%RK4       approximate the solution of the initial value problem
%
%                       x'(t) = FUNC( t, x ),    x(t0) = x0
%
%          using the classical Dopri 5(4)7 method - this 
%          routine will work for a system of first-order equations as 
%          well as for a single equation
%           
%          5th order solution
%          4th order time step calculation
%          7 stages
%
%     calling sequences:
%             [x, t] = rk4 ( RHS, t0, x0, tf, N )
%             rk4 ( RHS, t0, x0, tf, N )
%
%     inputs:
%             FUNC    string containing name of m-file defining the 
%                     right-hand side of the differential equation;  the
%                     m-file must take two inputs - first, the value of
%                     the independent variable; second, the value of the
%                     dependent variable
%             tspan   [to tf] of indepent variable from which to integrate 
%                     over
%             x0      initial value of the dependent variable(s)
%                     if solving a system of equations, this should be a 
%                     row vector containing all initial values
%             h0      innitial time step for which to begin integrating on,
%                     this will change adaptively during the course of the
%                     integration
%
%     output:
%             wi      vector / matrix containing values of the approximate 
%                     solution to the differential equation
%             ti      vector containing the values of the independent 
%                     variable at which an approximate solution has been
%                     obtained
%

%% Defines:
% Explicit 5th order Runge-Kutta Butcher Table:
alpha = [          0,           0,          0,        0,           0,     0 ;
                 1/5,           0,          0,        0,           0,     0 ;
                3/40,        9/40,          0,        0,           0,     0 ;
               44/45,      -56/15,       32/9,        0,           0,     0 ;
          19372/6561, -25360/2187, 64448/6561, -212/729,           0,     0 ;
           9017/3168,     -355/33, 46732/5247,   49/176, -5103/18656,     0 ;
              35/384,           0,   500/1113,  125/192,  -2187/6784, 11/84 ];
% 4th order beta vector:
beta4 = [ 5179/57600, 0.0, 7571/16695, 393/640, -92097/339200, 187/2100, 1/40 ];
% 5th order beta vector:
beta5 = [     35/384, 0.0,   500/1113, 125/192,    -2187/6784,    11/84,  0.0 ];
% 5th order c vector:
c = sum(alpha,2); % Sum of all rows of alpha
% "Margin Factio" (usually 0.8-0.9)
m = 0.8;
% Get size of alpha for ease:
[r,~] = size(alpha);

%% Set up:
% Number of equations:
neqn = length ( x0 );

% Get times:
t0 = min(tspan); tf = max(tspan);

% Innitialize vectors:
x0 = x0';
t = [t0]; x = [x0];

%% Runge-Kutta 5(4) function:
while(t0 < tf)
    % Innitialize sums and k-vector:
    k = zeros(r,neqn);
    sum4 = zeros(1,neqn);
    sum5 = zeros(1,neqn);
    % Compute k-vector and new states:
    for j=1:r

        % Definition of k-vector:
        % k1 = f(t,y + a11)
        % k2 = f(t + c2*h, yn + a21*k1)
        % k3 = f(t + c3*h, yn + a31*k1 + a32*k2)
        % ...
        % ks = f(t + cs*h, yn + as1*k1 + as2*k2 + ... + as,s-1*ks-1)

        % Compute summation (as1*k1 + as2*k2 + ... + as,s-1*ks-1):
        sumk = 0;
        for i=1:j-1
            sumk = sumk + alpha(j,i)*k( i, 1:neqn );
        end

        % Compute k:
        k( j, 1:neqn ) = feval ( FUNC, t0 + c(j) * h0, x0 + h0 * sumk, varargin{:} );

        % Compute pth and qth order deltas:
        sum4 = sum4 + beta4(j) * k( j, 1:neqn );
        sum5 = sum5 + beta5(j) * k( j, 1:neqn );
    end

    % Compute y_n+1 yh_n+1:
    y4 = x0 + h0 * sum4; % pth-order solution
    y5 = x0 + h0 * sum5; % qth-order solution
    
    % Calculate infinity norm:
    abs( y4 - y5 );
    delta = max( abs( y4 - y5 ) );

    % Calculate the local truncation error:
    epsilon = max( abs( y5 ) ) * rtol; % + (atol = 0)

    % Check if solution is valid:
    if( delta <= epsilon )
        % Solution is accepted, store it:
        % Update and store time:
        t0 = t0 + h0;
        t = [t; t0];
        
        % Store next state:
        x0 = y5;
        x = [x; x0];    
    else
        % Solution not accepted:
    end
    
    % Compute new stepsize:
    % hnew = hold*m*(e/d)^(1/(k+1)), where k = min(p,q) = 4, (1/(k+1)) = (1/5) = 0.2
    h0 = h0 * m * (epsilon/delta) ^ ( 0.2 );
   
end

end