%% Author : Deepak Karuppia  10/15/01

%% Generate 3D calibration pattern: 
%% Pw holds 32 points on two surfaces (Xw = 1 and Yw = 1) of a cube 
%%Values are measured in meters.
%% There are 4x4 uniformly distributed points on each surface.

cnt = 1;

%% plane : Xw = 1

for i=0.2:0.2:0.8,
 for j=0.2:0.2:0.8,
   Pw(cnt,:) = [1 i j];
   cnt = cnt + 1;
 end
end

%% plane : Yw = 1

for i=0.2:0.2:0.8,
 for j=0.2:0.2:0.8,
   Pw(cnt,:) = [i 1 j];
   cnt = cnt + 1;
 end
end

N = cnt;

%%plot3(Pw(:,1), Pw(:,2), Pw(:,3), '+');

%% Virtual camera model 

 %% Extrinsic parameters : R = RaRbRr

gamma = 40.0*pi/180.0;
Rr = [ [cos(gamma) -sin(gamma) 0];
       [sin(gamma) cos(gamma)  0];
       [  0          0         1]; ];

beta = 0.0*pi/180.0;

Rb = [ [cos(beta) 0 -sin(beta)];
       [0         1       0];
       [sin(beta) 0  cos(beta)]; ];

alpha = -120.0*pi/180.0;
Ra = [ [1      0                0];
       [0   cos(alpha)  -sin(alpha)];
       [0   sin(alpha)   cos(alpha)]; ];

R = Ra*Rb*Rr;

T = [0 0 4]';

%% Intrinsic parameters

f = 0.016;
Ox = 256;
Oy = 256;

Sx = 0.0088/512.0;
Sy = 0.0066/512.0;

Fx = f/Sx;
Fy = f/Sy;

%% asr is the aspect ratio
asr = Fx/Fy;

%% Generate Image coordinates

%% surface Xw = 1
cnt = 1;
for cnt = 1:1:16,
   Pc(cnt,:) = (R*Pw(cnt,:)' + T)';
   p(cnt,:)  = [(Ox - Fx*Pc(cnt,1)/Pc(cnt,3)) (Oy - Fy*Pc(cnt,2)/Pc(cnt,3))];
end
plot(p(:,1), p(:,2), 'r+');
axis([0 512 0 512]);
grid;
hold;

%% surface Yw = 1
for cnt = 17:1:32,
   Pc(cnt,:) = (R*Pw(cnt,:)' + T)';
   p(cnt,:)  = [(Ox - Fx*Pc(cnt,1)/Pc(cnt,3)) (Oy - Fy*Pc(cnt,2)/Pc(cnt,3))];
end
plot(p(17:32,1), p(17:32,2), 'g+');
%%plot3(Pc(:,1), Pc(:,2), Pc(:,3), '+');
grid;
