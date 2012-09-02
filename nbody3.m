function [dr] = nbody3(t,r0,MU)
%
% Inputs:  t - time
%          r0 - positions and velocities in 2D of vehicle, sun, and planets
%        
%          r0 = [Xv0, Yv0, Zv0, Uv0, Vv0, Wv0, Xs0, Ys0, Zv0, Us0, Vs0, Ws0, Xp1_0, Yp1_0, etc...]'
%          M  = [Mv, Ms, Mp1, Mp2, etc...]'
%

% Innitialize:
DOF = 6; % Degrees of freedom in 3-d problem
N = length(MU); % Number of bodies
dr = zeros(N*DOF,1); % Initialize derivative vector
 
% Form for each planet:
% Xp = r0(1);
% Yp = r0(2);
% Up = r0(3);
% Vp = r0(4);
 
for i=0:N-1
    
    % Integrate velocity to find position:
    % X = int[dx/dt = U], Y = int[dy/dt = V]
    % dXp = Up;
    % dYp = Vp;
    
    dr(i*DOF + 1) = r0(i*DOF + 4);
    dr(i*DOF + 2) = r0(i*DOF + 5);
    dr(i*DOF + 3) = r0(i*DOF + 6);
    
    % Integrate accleration to find velocity:
    % [Uv, Vv] = int[eq. of motion in sun barycenter frame = r_dotdot]
    
    % Initialize acceleration:
    dr(i*DOF + 4) = 0;
    dr(i*DOF + 5) = 0;
    dr(i*DOF + 6) = 0;
    
    % Sum up acceleration from each planet:
    for j=0:N-1
        
        % Planet has no pertubation due to itself
        if(j ~= i) 
            
            % Find r from planet i to planet j:
            % r = sqrt( (Xpi - Xpj)^2 + (Ypi - Ypj)^2 );
            rx = r0(i*DOF + 1) - r0(j*DOF + 1);
            ry = r0(i*DOF + 2) - r0(j*DOF + 2);
            rz = r0(i*DOF + 3) - r0(j*DOF + 3);
            r = sqrt(rx^2+ry^2+rz^2);
            
            % Calculate acceleration using equations of motion for  n-body
            % dUp += - G * Mj * rx / r^3;
            % dVp += - G * Mj * ry / r^3;
            if(r ~= 0)
                dr(i*DOF + 4) = dr(i*DOF + 4) - MU(j + 1) * rx / r^3;
                dr(i*DOF + 5) = dr(i*DOF + 5) - MU(j + 1) * ry / r^3;
                dr(i*DOF + 6) = dr(i*DOF + 6) - MU(j + 1) * rz / r^3;
            end
        end
    end
end
