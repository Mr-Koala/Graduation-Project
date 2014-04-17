function R = Tr(Tx,Ty,Tz)
% ROTATION ABOUT THE X,Y,Z AXIS
%
% R = Tr(Tx,Ty,Tz)
%
% This is the homogeneous transformation for
% rotation about the X,Y,Z axis.
%
%	    NOTE:  The angle Tx,Ty,Tz must be in DEGREES.
%
Tx = Tx*pi/180;
Ty = Ty*pi/180;
Tz = Tz*pi/180;
Cx = cos(Tx);Sx=sin(Tx);
Cy = cos(Ty);Sy=sin(Ty);
Cz = cos(Tz);Sz=sin(Tz);

%Rx = [1 0 0 0; 0 Cx -Sx 0; 0 Sx Cx 0; 0 0 0 1];
%Ry = [Cy 0 Sy 0; 0 1 0 0; -Sy 0 Cy 0; 0 0 0 1];
%Rz = [Cz -Sz 0 0; Sz Cz 0 0; 0 0 1 0; 0 0 0 1];

Rx = [1 0 0 ; 0 Cx -Sx ; 0 Sx Cx ];
Ry = [Cy 0 Sy ; 0 1 0 ; -Sy 0 Cy ];
Rz = [Cz -Sz 0 ; Sz Cz 0 ; 0 0 1 ];
R=Rx*Ry*Rz;
end

