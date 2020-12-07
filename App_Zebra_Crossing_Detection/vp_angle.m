%% ===========================================================
%% CSC I6716 Computer Vision 
%% @ Zhigang Zhu, CCNY
%% Homework 4 - programming assignment: 
%% The Way, the Truth, and the Life
%% 
%% Name: Ronald Adomako and (Alex) Xingye Li
%% ID: 16118977

%% Read in two images 
im = imread('zebra-crossing-3.jpg');

%[ROWS COLS CHANNELS] = size(im);
disimg = [im];
s = size(disimg);

%image(disimg);

edgeIm = edge(rgb2gray(im),'sobel');
%Threshold is at 95% by default

cmap = [0 1 1; 0 0 0; 1 1 0];
imshow(edgeIm,cmap)
%imshowpair(disimg,edgeIm,'montage');

%% size of the rectangle to indicate point locations in pixels
dR = 50;
dC = 50;
% Don't need to filter points at high threshold
% Using points selected by user is precise

'Select 4 points along a set of parallel lines'
hold on
[X, Y] = ginput(4);
%place Y in cartesian coordinates
XY_sort = sortrows([X,s(1)-Y])
X_sort = XY_sort(:,1);
Y_sort = XY_sort(:,2);

% Vanishing point is in the middle
ll = [X_sort(1); Y_sort(1)];
ul = [X_sort(2); Y_sort(2)];
ur = [X_sort(3); Y_sort(3)];
lr = [X_sort(4); Y_sort(4)];

% %create lines
% l1 = line(ll,ul);%[x1y1,x2y2]
% l2 = line(lr,ur);%[x3y3,x4y4]

[x1,x2,x3,x4] = deal(ll(1), ul(1), ur(1), lr(1));
[y1,y2,y3,y4] = deal(ll(2), ul(2), ur(2), lr(2));

%solve using inverse
numer = [x1*y2-x2*y1,x3*y4-x4*y3];
denom = [y2-y1,y4-y3;-(x2-x1),-(x4-x3)];


P = numer/denom;
vp_x = P(1);
vp_y = s(1) - P(2);
vp = [vp_x, vp_y];

%plot in computer coordinates
pX = [X_sort(1:2)', vp_x, X_sort(3:4)'];
pY = [s(1)-Y_sort(1:2)', vp_y, s(1)-Y_sort(3:4)'];

'leads pedestrian to other side of street'
%assume other end of cross-walk is in image
plot(pX,pY,'r');

%Angle
%Vertical line and point of intersection
dx = abs(s(2)/2 - vp_x);
dy = s(1) - vp_y

angRad = atan(dx/dy); %angle in radians

save vp.txt P -ASCII;%comp coords x->east, y->south
save angRad.txt angRad -ASCII; 

%return, save VP and angle

%mathworks.com/matlabcentral/answers/341125