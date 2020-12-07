%% Read in the image 
img = imread('zebra_crossing.jpg');

[ROWS COLS CHANNELS] = size(img);

image(img);


Nc = 2;
Nl = 2;

n_line = 1;
hold;

while(n_line <= Nl)
    cnt = 1;
    while(cnt <= Nc)
    %% pick up two points in the image
    %%% if you loaded the point matches, comment the point picking up (3 lines)%%%
    [X, Y] = ginput(1);
    C = X(1); R = Y(1);
    p(cnt,:) = [C R];

    %% and draw it 
    plot(p(cnt,1),p(cnt,2),'r*','MarkerSize',12);

    cnt = cnt+1;
    end
    coefficients = polyfit([p(1,1), p(2,1)], [p(1,2), p(2,2)], 1);
    a = coefficients (1);
    b = coefficients (2);
    lines(n_line,:) = [a b];
    x = 0:COLS; 
    y = a*x + b;
    line(x,y,'Color', 'b','LineWidth',2);
    n_line = n_line+1;
end

[X, Y] = ginput(1);
C = X(1); R = Y(1);
vpl = [C R];
plot(vpl(1),vpl(2),'b*','MarkerSize',12);

[X, Y] = ginput(1);
C = X(1); R = Y(1);
vpr = [C R];
plot(vpr(1),vpr(2),'b*','MarkerSize',12);

vp_x = int32((lines(2,2) - lines(1,2))/(lines(1,1) - lines(2,1)));
vp_y = int32(lines(1,1)*vp_x+lines(1,2));
plot(vp_x,vp_y,'r.','MarkerSize',15);

upper_img = img(1:vp_y,:,:);

I = rgb2gray(upper_img);

Iblur = imgaussfilt(I,2);
Kmedian = medfilt2(I, [13,13]);

[L,Centers] = imsegkmeans(Kmedian,2);
%B = labeloverlay(I,L);
%figure();
%imshow((L-1)*255)
[seg,Centers] = imsegkmeans(img,2);
B = labeloverlay(img,seg);
figure();
imshow((seg-1)*255)
figure();
imshow(B)

depth_map = zeros(ROWS,COLS);
%% Ground 2
coefficients = polyfit([double(vpl(1)), double(vp_x)], [double(vpl(2)), double(vp_y)], 1);
a1 = coefficients(1);
b1 = coefficients(2);

coefficients = polyfit([double(vpr(1)), double(vp_x)], [double(vpr(2)), double(vp_y)], 1);
a2 = coefficients(1);
b2 = coefficients(2);


for x = 1:vp_x
    for y = int32(x*a1 + b1):ROWS
        depth_map(y,x) = 255*(y-vp_y)/(ROWS-vp_y);
    end
    y = int32(x*a1 + b1);
    depth_map(1:y,x) = 255*(y-vp_y)/(ROWS-vp_y);
end


for x = vp_x:COLS
    for y = int32(x*a2 + b2):ROWS
        depth_map(y,x) = 255*(y-vp_y)/(ROWS-vp_y);
    end
    y = int32(x*a2 + b2);
    depth_map(1:y,x) = 255*(y-vp_y)/(ROWS-vp_y);
end

%% Ground 1

for x = 1:vp_x
    for y = 1:(a1*x+b1)
        %depth = 255*(vp_x-x)/vp_x;
        %depth_map(y,x) = depth;
        if y<vp_y
            if L(y,x)-1 == 0
                depth_map(y,x) = 0;
            end
        end
    end
end

%% Ground 3
for x = vp_x:COLS
    for y = 1:(a2*x+b2)
        %depth = 255*(x-vp_x)/(COLS-vp_x);
        %depth_map(y,x) = depth;
        if y<vp_y
            if L(y,x)-1 == 0
                depth_map(y,x) = 0;
            end
        end
    end
end


figure();
imshow(depth_map./255)




