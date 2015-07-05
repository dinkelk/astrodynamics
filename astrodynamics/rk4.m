function [t, x] = rk4( FUNC, tspan, x0, N, varargin)

%RK4       approximate the solution of the initial value problem
%
%                       x'(t) = FUNC( t, x ),    x(t0) = x0
%
%          using the classical fourth-order Runge-Kutta method - this 
%          routine will work for a system of first-order equations as 
%          well as for a single equation
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
%             N       number of uniformly sized time steps to be taken to
%                     advance the solution from t = t0 to t = tf
%
%     output:
%             wi      vector / matrix containing values of the approximate 
%                     solution to the differential equation
%             ti      vector containing the values of the independent 
%                     variable at which an approximate solution has been
%                     obtained
%

% Number of equations:
neqn = length ( x0 );

% Create indepenent variable vector:
t0 = tspan(1); tf = tspan(2);
t = linspace( t0, tf, N+1 )';

% Create dependent variable vector:
x = zeros( N+1, neqn );

% Set innitial value:
x( 1, 1:neqn) = x0';

% Define step size:
h = ( tf - t0 ) / N;

% Loop over all integration steps:
for i = 1:N
    % Solve for k-values:
    k1 = h * feval ( FUNC, t0, x0, varargin{:} );
	k2 = h * feval ( FUNC, t0 + h/2, x0 + k1/2, varargin{:} );
	k3 = h * feval ( FUNC, t0 + h/2, x0 + k2/2, varargin{:} );
	k4 = h * feval ( FUNC, t0 + h, x0 + k3, varargin{:} );
    
    % Solve for new state:
    x0 = x0 + ( k1 + 2*k2 + 2*k3 + k4 ) / 6;
	t0 = t0 + h;
	
    % Store new state:
    x( i+1, 1:neqn ) = x0';	
end

end