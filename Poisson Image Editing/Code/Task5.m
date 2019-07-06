close all;
clear;
clc;

%% first region 
%Read image
SourceImage = imread('5.jpg');
TargetImage = imread('5.jpg');
%Change the image to grayscale image
SourceR = SourceImage(:,:,1);
SourceG = SourceImage(:,:,2);
SourceB = SourceImage(:,:,3);
TargetR = TargetImage(:,:,1);
TargetG = TargetImage(:,:,2);
TargetB = TargetImage(:,:,3);
%Calculate the size of the grayscale image
[row_source, col_source] = size(SourceR);
[row_target, col_target] = size(TargetR);
imshow(SourceImage);

%Choose the region
h = impoly(gca,[350 282;353 298;299 297;296 284;309 269;328 267;341 271]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
SourceR = double(SourceR);
SourceG = double(SourceG);
SourceB = double(SourceB);

%Obtain target mask
MaskTarget = SourceMask;

%Obtain the cols and rows of the mask of source
[Col_source,Row_source] = SizeSource(SourceMask,row_source,col_source);

%Extract boundary
TargBoundry = bwboundaries(MaskTarget,8);
TargBoundry = TargBoundry{1};
boundary = zeros(row_target,col_target);
for i = 1:size(TargBoundry)
    boundary(TargBoundry(i,1),TargBoundry(i,2)) = 1;
end

%Substitute boundary
MaskTarget = MaskTarget - boundary;

%Find selected region's cols and rows
[Col,Row] = find(transpose(MaskTarget));

%Obtain the sprase matrix A
A = zeros(size(Row,1),size(Row,1));
for i = 1:size(Row,1)
    for j = 1:size(Row,1)
        
        if abs(Row(i)-Row(j))==1 && abs(Col(i)-Col(j))==0
            A(i,j) = -1;
        elseif abs(Row(i)-Row(j))==0 && abs(Col(i)-Col(j))==1
            A(i,j) = -1;
        end
        
        if i == j
            A(i,j) = 4;
        end
        
    end
end

%Calculate Ax=b
ResultImgR= PoissonSolver(A,SourceR*0.5,Row,Col,Row_source,Col_source,double(TargetR),boundary);
ResultImgG= PoissonSolver(A,SourceG*0.5,Row,Col,Row_source,Col_source,double(TargetG),boundary);
ResultImgB= PoissonSolver(A,SourceB*0.5,Row,Col,Row_source,Col_source,double(TargetB),boundary);
ResultImg = cat(3, ResultImgR, ResultImgG, ResultImgB);

%Show the result image
figure;imshow(ResultImg);
% imshow(ResultImgR);
% imshow(ResultImgG);
% imshow(ResultImgB);

%% second region 

figure;imshow(ResultImg);

%Choose the region
h = impoly(gca,[296 285;298 297;251 296;251 287;248 278;256 271;271 269;287 273]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
SourceR = double(ResultImgR);
SourceG = double(ResultImgG);
SourceB = double(ResultImgB);
%Obtain target mask
MaskTarget = SourceMask;

%Obtain the cols and rows of the mask of source
[Col_source,Row_source] = SizeSource(SourceMask,row_source,col_source);

%Extract boundary
TargBoundry = bwboundaries(MaskTarget,8);
TargBoundry = TargBoundry{1};
boundary = zeros(row_target,col_target);
for i = 1:size(TargBoundry)
    boundary(TargBoundry(i,1),TargBoundry(i,2)) = 1;
end

%Substitute boundary
MaskTarget = MaskTarget - boundary;

%Find selected region's cols and rows
[Col,Row] = find(transpose(MaskTarget));

%Obtain the sprase matrix A
A = zeros(size(Row,1),size(Row,1));
for i = 1:size(Row,1)
    for j = 1:size(Row,1)
        
        if abs(Row(i)-Row(j))==1 && abs(Col(i)-Col(j))==0
            A(i,j) = -1;
        elseif abs(Row(i)-Row(j))==0 && abs(Col(i)-Col(j))==1
            A(i,j) = -1;
        end
        
        if i == j
            A(i,j) = 4;
        end
        
    end
end

%Calculate Ax=b
ResultImgR= PoissonSolver(A,SourceR*0.3,Row,Col,Row_source,Col_source,SourceR,boundary);
ResultImgG= PoissonSolver(A,SourceG*0.5,Row,Col,Row_source,Col_source,SourceG,boundary);
ResultImgB= PoissonSolver(A,SourceB*0.3,Row,Col,Row_source,Col_source,SourceB,boundary);
ResultImg = cat(3, ResultImgR, ResultImgG, ResultImgB);

%Show the result image
imshow(ResultImg);

%% third region 

figure;imshow(ResultImg);

%Choose the region
h = impoly(gca,[249 279;251 297;197 296;198 282;205 267;214 262;226 261;239 265]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
SourceR = double(ResultImgR);
SourceG = double(ResultImgG);
SourceB = double(ResultImgB);
%Obtain target mask
MaskTarget = SourceMask;

%Obtain the cols and rows of the mask of source
[Col_source,Row_source] = SizeSource(SourceMask,row_source,col_source);

%Extract boundary
TargBoundry = bwboundaries(MaskTarget,8);
TargBoundry = TargBoundry{1};
boundary = zeros(row_target,col_target);
for i = 1:size(TargBoundry)
    boundary(TargBoundry(i,1),TargBoundry(i,2)) = 1;
end

%Substitute boundary
MaskTarget = MaskTarget - boundary;

%Find selected region's cols and rows
[Col,Row] = find(transpose(MaskTarget));

%Obtain the sprase matrix A
A = zeros(size(Row,1),size(Row,1));
for i = 1:size(Row,1)
    for j = 1:size(Row,1)
        
        if abs(Row(i)-Row(j))==1 && abs(Col(i)-Col(j))==0
            A(i,j) = -1;
        elseif abs(Row(i)-Row(j))==0 && abs(Col(i)-Col(j))==1
            A(i,j) = -1;
        end
        
        if i == j
            A(i,j) = 4;
        end
        
    end
end

%Calculate Ax=b
ResultImgR= PoissonSolver(A,SourceR*0.4,Row,Col,Row_source,Col_source,SourceR,boundary);
ResultImgG= PoissonSolver(A,SourceG*0.7,Row,Col,Row_source,Col_source,SourceG,boundary);
ResultImgB= PoissonSolver(A,SourceB*0.1,Row,Col,Row_source,Col_source,SourceB,boundary);
ResultImg = cat(3, ResultImgR, ResultImgG, ResultImgB);

%Show the result image
imshow(ResultImg);