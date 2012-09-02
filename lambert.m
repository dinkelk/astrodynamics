%
% Written by: Kevin Dinkel
% ASEN 6008
% 2/8/2012
%
function [V0,Vf] = lambert(R0,Rf,dt0,MU)
%
%
% Inputs:
%      R0   = [Ri, Rj, Rk] (innitial radius vector) in km
%      Rf   = [Ri, Rj, Rk] (final radius vector) in km
%      dt0  = time of flight in seconds
%      DM   = direction of motion (+1 or -1)
%      MU   = gravitational constant of central body
%
% Outputs:
%      V0  = the velocity vector at R0 in km/s to complete transfer
%            (ie. Velocity at periapsis for a hohmann from Earth to Mars)
%      Rf  = the velocity vector at Rf in km/s to complete transfer
%            (ie. Velocity at apoapsis for a hohmann from Earth to Mars)
%
%
%% Lambert Solver:
    % Progress stuff:
    progress_tolerance = 1e-100;
    psi_old = -1;
    counter = 0;
    max_count = 1000;
    
    % Tolerences
    tol = 1e-6;
    
    % Compute r0, rf, delta_nu, & A:
    r0 = norm(R0);
    rf = norm(Rf);
    
    cosnu = dot(R0,Rf)/r0/rf;
    
    % Find delta_nu:
    nu1 = atan2(R0(2),R0(1));
    nu2 = atan2(Rf(2),Rf(1));
    delta_nu = nu2-nu1;
    if delta_nu < 0
       delta_nu = delta_nu + 2*pi;
    end

    % Determine Type I or Type II trajectory:
    if delta_nu <= pi
       DM = 1;
    else
        DM = -1;
    end
    
    A = DM*sqrt(r0*rf*(1+cosnu));

    % Check input:
    if( delta_nu == 0 || A == 0 )
        disp('delta_nu = 0 || A = 0, Trajectory cannot be computed.');
        return
    end
    
    % Innitial values:
    psi = 0;
    c2 = 1/2; c3 = 1/6;
    psi_up = 4*pi^2;
    psi_low = -4*pi;
    
    % Iterate:
    while( 1 )
        
        % Calculate y:
        y = r0 + rf + A*(psi*c3-1)/sqrt(c2);
        
        while( A > 0.0 && y < 0.0 )
           psi = psi+.1;
           y = r0 + rf + A*(psi*c3-1)/sqrt(c2);
        end
             
        % Calculate new dt:
        Chi = sqrt(y/c2);
        dt = (Chi^3*c3 + A*sqrt(y)) / sqrt(MU);
        
        %%% Success condition: %%%
        if(abs(dt - dt0) < tol)
            break;
        end
        %%%%%%%%%%%%%%%%%%%%%%%
        
        %%% Error condition: %%%
        %abs(psi - psi_old)
        %psi
        if( abs(psi - psi_old) < progress_tolerance)
            y = nan; % Exit with error!!
            break;
        end
        psi_old = psi;
        %%%%%%%%%%%%%%%%%%%%%%%
        
        %% Error condition: %%%
        if( counter > max_count)
            y = nan; % Exit with error!!
            break;
        end
        counter = counter + 1;
        %%%%%%%%%%%%%%%%%%%%%%
        
        % Adjust psi (bi-section method):
        if ( dt <= dt0 )
            psi_low = psi;
        else
            psi_up = psi;
        end
        psi = (psi_up + psi_low) / 2;
        
        % Adjust c3 & c3:
        if ( psi > 1e-6 )
            c2 = (1.0 - cos(sqrt(psi))) / psi;
            c3 = (sqrt(psi) - sin(sqrt(psi))) / sqrt(psi^3);
        elseif( psi < -1e-6 )
            c2 = (1.0 - cosh(sqrt(-psi))) / psi;
            c3 = (sinh(sqrt(-psi)) - sqrt(-psi)) / sqrt((-psi)^3);
        else
            c2 = 1/2; c3 = 1/6;
        end
    end
        
    % Compute velocities:
    f = 1 - y/r0;
    gdot = 1 - y/rf;
    g = A*sqrt(y/MU);
 
    V0 = (Rf - f*R0) / g;
    Vf = (gdot*Rf - R0) / g;
    
return