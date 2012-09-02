function rot1 = rot1(alpha)

rot1 = [ 
          1 0 0;
          0 cos(alpha) sin(alpha);
          0 -sin(alpha) cos(alpha);
        ];

end