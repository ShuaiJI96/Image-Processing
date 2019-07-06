%% Some parameters to set - make sure that your code works at image borders!

% Row and column of the pixel for which we wish to find all similar patches 
% NOTE: For this section, we pick only one patch
% set a fix point
row = 15;
col = 12;

% Patchsize - make sure your code works for different values
patchSize = 9;

% Search window size - make sure your code works for different values
searchWindowSize = 7;


%% Implementation of work required in your basic section-------------------

% TODO - Load Image
%image = zeros(100, 100);
image = imread('images\alleyNoisy_sigma20.png');
image = double(image);

%obtain the integral image
image_ii = computeIntegralImage(image);
% TODO - Display the normalised Integral Image 
% NOTE: This is for display only, not for template matching yet!

%figure('name', 'Normalised Integral Image');
f= (searchWindowSize-1)/2;
r = (patchSize-1)/2;

%Patchwindow (patchSize*patchSize)
num = 1;
for i = 0:searchWindowSize - 1
    for j = 0:searchWindowSize - 1
        offsetsRows(num) = (1-searchWindowSize)/2 +i;
        offsetsCols(num) = (1-searchWindowSize)/2 +j;
        num = num + 1;
    end
end

image_board = padarray(image(:,:,1:3),[f+r f+r],'replicate','both');
% TODO - Template matching for naive SSD (i.e. just loop and sum)
distances_naive = Naive(row, col,image_board,patchSize, searchWindowSize,r,f);
%distances_naive = distances_naive/(3*patchSize*patchSize);
% TODO - Template matching using integral images
distances_ii = Integral(row, col,image,patchSize, searchWindowSize);
%distances_ii = distances_ii/(3*patchSize*patchSize);

%% Let's print out your results--------------------------------------------

% NOTE: Your results for the naive and the integral image method should be
% the same!
for i=1:length(offsetsRows)
    disp(['offset rows: ', num2str(offsetsRows(i)), '; offset cols: ',...
        num2str(offsetsCols(i)), '; Naive Distance = ', num2str(distances_naive(i),10),...
        '; Integral Im Distance = ', num2str(distances_ii(i),10)]);
end