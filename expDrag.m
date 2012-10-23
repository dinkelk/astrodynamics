function [rho_A, V_A] = expDrag(x)
    % Calculate the spacecraft radius length:
    r = norm(x(1:3));
    
    % Add in drag terms:
    H = 88667.0; % m
    rho0 = 3.614E-13; % kg/m^3
    r_zero = 7078136.3; % m
    theta_dot = 7.2921158553E-5; % rad/s

    % Solve for the atmospheric density:
    rho_A = rho0 * exp(-(r - r_zero)/H);
    
    % Solve for the atmospheric velocity:
    V_A = [x(4) + theta_dot*x(2); x(5) - theta_dot*x(1); x(6)];
end