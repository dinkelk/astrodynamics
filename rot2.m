function T = rot2(alpha)
%
% Given an angle alpha, this function provides a positive right hand 
% coordinate frame rotation about the positive Y-axis. This means that any
% vector from frame 1 left-multiplied by this matrix will be transformed 
% into frame 2 to using a negative rotation about the Y-axis, because the 
% coordinate frame is rotating positively underneath the vector. (Use the 
% right hand rule for positive and negative rotation determination). To 
% actually rotate a vector in a positive fashion within a single frame a 
% negative alpha must be provided.
%
% These rotation matrices are in the form provided by Dr. Schaub.
%
% Inputs: alpha = rotation angle in radians
%
% Outputs:    T = the transformation matrix
%

cosA = cos(alpha);
sinA = sin(alpha);

T = [ 
          cosA 0 -sinA;
          0 1 0;
          sinA  0 cosA;
    ];
    
end