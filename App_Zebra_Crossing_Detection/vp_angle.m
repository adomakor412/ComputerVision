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

[ROWS COLS CHANNELS] = size(im);
disimg = [im];
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
[X, Y] = ginput(4);
X_sort = sort(X)
Y_sort = sort(Y)

% Vanishing point is in the middle
ll = [X_sort(1); Y_sort(1)];
lr = [X_sort(4); randsample(Y_sort(1:2),1)];
ul = [X_sort(2); randsample(Y_sort(3:4),1)];
ur = [X_sort(3); randsample(Y_sort(3:4),1)];

% %create lines
% l1 = line(ll,ul);%[x1y1,x2y2]
% l2 = line(lr,ur);%[x3y3,x4y4]

[x1,x2,x3,x4] = [ll(1),ul(1),lr(1),ur(1)];
[y1,y2,y3,y4] = [ll(2),ul(2),lr(2),ur(2)];

%Vertical line and point of intersection
numer = [x1*y2-x2*y1;x3*y4-x4*y3];
denom = [y2-y1,y4-y3;-(x2-x1),-(x4-x3)];
P = numer/denom
P  = P(3:4)
display(P)

%Angle

%return, save VP and angle