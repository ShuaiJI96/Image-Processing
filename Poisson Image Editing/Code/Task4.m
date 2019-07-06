close all;
clear;
clc;

%% region one
%Read image
SourceImage = imread('42.jpg');
TargetImage = imread('41.jpg');
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
%h = impoly(gca,[192.422556390977 83.715037593985;148.013533834586 83.3;140.957894736842 69.6037593984962;113.98045112782 66.6984962406015;96.9639097744361 72.509022556391;62.9308270676692 66.6984962406015;65.006015037594 48.0218045112782;82.4375939849624 41.3812030075188;108.16992481203 45.5315789473684;120.206015037594 60.887969924812;141.372932330827 62.5481203007519;159.634586466165 56.3225563909774;188.687218045113 67.1135338345865]);
h = impoly(gca,[174.980169971671 180.052407932011;163.773371104816 190.771954674221;143.796033994334 191.259206798867;131.127478753541 190.771954674221;113.099150141643 180.052407932011;104.815864022663 168.845609065156;101.405099150142 161.536827195467;101.892351274788 150.330028328612;103.354107648725 134.737960339943;141.847025495751 139.123229461756;167.184135977337 144.483002832861;185.212464589235 152.766288951841;183.263456090652 165.434844192635]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
SourceR = double(SourceR);
SourceG = double(SourceG);
SourceB = double(SourceB);

%Obtain target mask
%position_in_target = [145, 95];
position_in_target = [155, 155];
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


%% region two
SourceImage = imread('43.jpg');
SourceImage = imresize(SourceImage,0.65,'nearest');
figure;imshow(SourceImage);
%h = impoly(gca,[195.330769230769 113.782051282051;158.694871794872 109.925641025641;152.636610150374 85.9023010364633;145.064753862948 85.0609836711933;137.163247863248 103.176923076923;101.81282051282 102.534188034188;89.2794871794872 76.1820512820512;97.1668118828313 67.2671272093602;127.99690897021 67.621496141399;143.38211913241 75.3858339705953;157.263855659356 77.4891273837683;186.332478632479 77.4675213675213;207.221367521368 91.6076923076923]);
h = impoly(gca,[208.354651162791 123.75;169.912790697674 118.691860465116;165.191860465116 92.7267441860465;159.122093023256 91.7151162790698;146.308139534884 113.970930232558;107.529069767442 109.25;98.7616279069767 83.6220930232558;108.415626513673 72.6058041115955;149.008523368706 75.1178031158274;157.867746669677 82.2051817566041;174.296511627907 82.2732558139535;210.71511627907 86.6569767441861;224.877906976744 102.843023255814]);
%Create a mask to this region
SourceMask = createMask(h);
%Change the format from uint8 to double
SourceR = double(SourceImage(:,:,1));
SourceG = double(SourceImage(:,:,2));
SourceB = double(SourceImage(:,:,3));
%Calculate the size of the grayscale image
[row_source, col_source] = size(SourceR);

%Obtain target mask
position_in_target = [145, 90];
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
ResultImgR= PoissonSolver(A,SourceR,Row,Col,Row_source,Col_source,double(ResultImgR),boundary);
ResultImgG= PoissonSolver(A,SourceG,Row,Col,Row_source,Col_source,double(ResultImgG),boundary);
ResultImgB= PoissonSolver(A,SourceB,Row,Col,Row_source,Col_source,double(ResultImgB),boundary);

ResultImg = cat(3, ResultImgR, ResultImgG, ResultImgB);

imshow(ResultImg);
