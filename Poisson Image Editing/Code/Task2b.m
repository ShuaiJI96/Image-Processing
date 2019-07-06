close all;
clear;
clc;

%Read image
SourceImage = imread('1.jpg');
TargetImage = imread('2.jpg');
%Change the image to grayscale image
GreySource = rgb2gray(SourceImage);
GreyTarget = double(rgb2gray(TargetImage));
%Calculate the size of the grayscale image
[row_source, col_source] = size(GreySource);
[row_target, col_target] = size(GreyTarget);
imshow(GreySource);

%Choose the region
h = impoly(gca,[216 143;240 201;128 201;142 151;136 128;127 108;123 70;136 58;155 78;188 72;201 51;217 86;225 105]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
GreySource = double(GreySource);
GreyTarget = double(GreyTarget);

%Obtain target mask
position_in_target = [20, 70];
MaskTarget = ObjectMove(position_in_target,GreyTarget,SourceMask);

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

% temp = [0 -1 0; -1 4 -1; 0 -1 0];
% div = imfilter(double(GreySource), temp, 'replicate');
tempSource = padarray(GreySource,[1 1],'replicate','both');
div_source = 4*tempSource - circshift(tempSource,1,1) - circshift(tempSource,-1,1) - circshift(tempSource,1,2) - circshift(tempSource,-1,2);
abs_source = abs(div_source);
tempTarget = padarray(GreyTarget,[1 1],'replicate','both');
div_target = 4*tempTarget - circshift(tempTarget,1,1) - circshift(tempTarget,-1,1) - circshift(tempTarget,1,2) - circshift(tempTarget,-1,2);
abs_target = abs(div_target);

%Obtain the divergence b
b = zeros(size(Row,1),1);
for i = 1:size(Row,1)
    if abs_target(Row(i)+1,Col(i)+1) > abs_source(Row_source(i)+1,Col_source(i)+1)
        b(i) = div_target(Row(i)+1,Col(i)+1);
    else
        b(i) = div_source(Row_source(i)+1,Col_source(i)+1);
    end
    
    if boundary(Row(i)+1,Col(i)) == 1
        b(i) = b(i) + GreyTarget(Row(i)+1,Col(i));
    end
    if boundary(Row(i)-1,Col(i)) == 1
        b(i) = b(i) + GreyTarget(Row(i)-1,Col(i));
    end
    if boundary(Row(i),Col(i)+1) == 1
        b(i) = b(i) + GreyTarget(Row(i),Col(i)+1);
    end
    if boundary(Row(i),Col(i)-1) == 1
        b(i) = b(i) + GreyTarget(Row(i),Col(i)-1);
    end
end

%Calculate intensity
x = A\b;
ResultImg = GreyTarget;
for i=1:size(Row,1)
    ResultImg(Row(i),Col(i)) = x(i);
end
ResultImg = uint8(ResultImg);

%Show the result image
imshow(ResultImg);