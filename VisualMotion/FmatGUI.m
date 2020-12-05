%% ===========================================================
%% CSC I6716 Computer Vision 
%% @ Zhigang Zhu, CCNY
%% Homework 4 - programming assignment: 
%% Fundamental Matrix and Feature-Based Stereo Matching
%% 
%% Name:
%% ID:
%%
%% Note: Please do not delete the commented part of the code.
%% I am going to use it to test your program
%% =============================================================

%% Read in two images 
imgl = imread('pic410.bmp');
imgr = imread('pic430.bmp');

%% display image pair side by side
[ROWS COLS CHANNELS] = size(imgl);
disimg = [imgl imgr];
image(disimg);

% You can change these two numbers, 
% but use the variables; I will use them
% to load my data to test your algorithms
% Total Number of control points

Nc = 12;
% Total Number of test points
Nt = 4;

%% After several runs, you may want to save the point matches 
%% in files (see below and then load them here, instead of 
%% clicking many point matches every time you run the program

%% load pl.mat pl;
%% load pr.mat pr;

%% interface for picking up both the control points and 
%% the test points

cnt = 1;
hold;

while(cnt <= Nc+Nt)

%% size of the rectangle to indicate point locations
dR = 50;
dC = 50;

%% pick up a point in the left image and display it with a rectangle....
%%% if you loaded the point matches, comment the point picking up (3 lines)%%%
[X, Y] = ginput(1);
Cl = X(1); Rl = Y(1);
pl(cnt,:) = [Cl Rl 1];

%% and draw it 
Cl= pl(cnt,1);  Rl=pl(cnt,2); 
rectangle('Curvature', [0 0], 'Position', [Cl Rl dC dR]);

%% and then pick up the correspondence in the right image
%%% if you loaded the point matches, comment the point picking up (three lines)%%%

[X, Y] = ginput(1);
Cr = X(1); Rr = Y(1);
pr(cnt,:) = [Cr-COLS Rr 1];

%% draw it
Cr=pr(cnt,1)+COLS; Rr=pr(cnt,2);
rectangle('Curvature', [0 0], 'Position', [Cr Rr dC dR]);
%plot(Cr+COLS,Rr,'r*');
drawnow;

cnt = cnt+1;
end

%% Student work (1a) NORMALIZATION: Page 156 of the textbook and Ex 7.6
%% --------------------------------------------------------------------
%% Normalize the coordinates of the corresponding points so that
%% the entries of A are of comparable size
%% You do not need to do this, but if you cannot get correct
%% result, you may want to use this 




%% END NORMALIZATION %%

%% Student work: (1b) Implement EIGHT_POINT algorithm, page 156
%% --------------------------------------------------------------------
%% Generate the A matrix

%% Singular value decomposition of A

%% the estimate of F


% Undo the coordinate normalization if you have done normalization



%% END of EIGHT_POINT

%% Draw the epipolar lines for both the controls points and the test
%% points, one by one; the current one (* in left and line in right) is in
%% red and the previous ones turn into blue

%% I suppose that your Fundamental matrix is F, a 3x3 matrix

%% Student work (1c): Check the accuray of the result by 
%% measuring the distance between the estimated epipolar lines and 
%% image points not used by the matrix estimation.
%% You can insert your code in the following for loop

for cnt=1:1:Nc+Nt,
  an = F*pl(cnt,:)';
  x = 0:COLS; 
  y = -(an(1)*x+an(3))/an(2);

  x = x+COLS;
  plot(pl(cnt,1),pl(cnt,2),'r*');
  line(x,y,'Color', 'r');
  [X, Y] = ginput(1); %% the location doesn't matter, press mouse to continue...
  plot(pl(cnt,1),pl(cnt,2),'b*');
  line(x,y,'Color', 'b');

end 

%% Save the corresponding points for later use... see discussions above
%save pr.mat pr;
%save pl.mat pl;

%% Save the F matrix in ascii
save F.txt F -ASCII

% Student work (1d): Find epipoles using the EPIPOLES_LOCATION algorithm page. 157
%% --------------------------------------------------------------------



%% save the eipoles 

save eR.txt eRv -ASCII; 
save eL.txt eRv -ASCII; 

% Student work (2). Feature-based stereo matching
%% --------------------------------------------------------------------
%% Try to use the epipolar geometry derived from (1) in searching  
%% correspondences along epipolar lines in Question (2). You may use 
%% a similar interface  as I did for question (1). You may use the point 
%% match searching algorithm in (1) (if you have done so), but this 
%% time you need to constrain your search windows along the epipolar lines.

