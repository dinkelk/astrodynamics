

function [A] = ephimerides(JDE,planet)

    a = ephemerides_coefficients(planet);
    
    T = (JDE - 2451545.0) / 36525;
    
    E(1)     = a(1,1) + a(1,2)*T + a(1,3)*T^2 + a(1,4)*T^3;
    E(2)     = a(2,1) + a(2,2)*T + a(2,3)*T^2 + a(2,4)*T^3;
    E(3)     = a(3,1) + a(3,2)*T + a(3,3)*T^2 + a(3,4)*T^3;
    E(4)     = a(4,1) + a(4,2)*T + a(4,3)*T^2 + a(4,4)*T^3;
    E(5)     = a(5,1) + a(5,2)*T + a(5,3)*T^2 + a(5,4)*T^3;
    E(6)     = a(6,1) + a(6,2)*T + a(6,3)*T^2 + a(6,4)*T^3;
   
    A = MeeustoCOE(E);
    
    return
end
      