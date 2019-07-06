close all;
clear;
clc;

%Read image
SourceImage = imread('1.jpg');
TargetImage = imread('2.jpg');
%Change the image to grayscale image
SourceR = SourceImage(:,:,1);
SourceG = SourceImage(:,:,2);
SourceB = SourceImage(:,:,3);
TargetR = TargetImage(:,:,1);
TargetG = TargetImage(:,:,2);
TargetB = TargetImage(:,:,3);
GreyTarget = rgb2gray(TargetImage);
%Calculate the size of the grayscale image
[row_source, col_source] = size(SourceR);
[row_target, col_target] = size(TargetR);
imshow(SourceImage);

%Choose the region
h = impoly(gca,[217 142;240 201;132 201;142 146;132 127;127 108;126 71;132 60;156 74;188 70;202 55;217 86;225 105]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
SourceR = double(SourceR);
SourceG = double(SourceG);
SourceB = double(SourceB);

%Obtain target mask
position_in_target = [10, 225];
MaskTarget = ObjectMove(position_in_target,TargetG,SourceMask);

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
ResultImgR= PoissonSolver(A,SourceR,Row,Col,Row_source,Col_source,double(TargetR),boundary);
ResultImgG= PoissonSolver(A,SourceG,Row,Col,Row_source,Col_source,double(TargetG),boundary);
ResultImgB= PoissonSolver(A,SourceB,Row,Col,Row_source,Col_source,double(TargetB),boundary);

ResultImg = cat(3, ResultImgR, ResultImgG, ResultImgB);

%Show the result image
imshow(ResultImg);
% imshow(ResultImgR);
% imshow(ResultImgG);
% imshow(ResultImgB);