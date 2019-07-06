close all;
clear;
clc;

%Read image
SourceImage = imread('1.jpg');
%Change the image to grayscale image
GreySource = rgb2gray(SourceImage);
%Calculate the size of the grayscale image
[row, col] = size(GreySource);
imshow(GreySource);

%Choose the region
h = impoly(gca,[220 144;240 201;132 201;135 151;132 127;127 108;123 70;127 53;155 72;186 67;203 47;217 86;225 105]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
GreySource = double(GreySource);

%Extract boundary
TargBoundry = bwboundaries(SourceMask,8);
TargBoundry = TargBoundry{1};
boundary = zeros(row,col);
for i = 1:size(TargBoundry)
    boundary(TargBoundry(i,1),TargBoundry(i,2)) = 1;
end

%Substitute boundary
SourceMask = SourceMask - boundary;

%Find selected region's cols and rows
[Col,Row] = find(transpose(SourceMask));


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

%Obtain the divergence b
b = zeros(size(Row,1),1);
for i = 1:size(Row,1)
    if boundary(Row(i)+1,Col(i)) == 1
        b(i) = b(i) + GreySource(Row(i)+1,Col(i));
    end
    if boundary(Row(i)-1,Col(i)) == 1
        b(i) = b(i) + GreySource(Row(i)-1,Col(i));
    end
    if boundary(Row(i),Col(i)+1) == 1
        b(i) = b(i) + GreySource(Row(i),Col(i)+1);
    end
    if boundary(Row(i),Col(i)-1) == 1
        b(i) = b(i) + GreySource(Row(i),Col(i)-1);
    end
end

%Calculate intensity
x = A\b;
ResultImg = GreySource;
for i=1:size(Row,1)
    ResultImg(Row(i),Col(i)) = x(i);
end
ResultImg = uint8(ResultImg);

%Show the result image
imshow(ResultImg);