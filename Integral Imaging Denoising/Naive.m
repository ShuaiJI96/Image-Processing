function distances = Naive(row, col,...
    image_board,patchSize, searchWindowSize,r,f)
% This function should for each possible offset in the search window
% centred at the current row and col, save a value for the offsets and
% patch distances, e.g. for the offset (-1,-1)


% The distance is simply the SSD over patches of size patchSize between the
% 'template' patch centred at row and col and a patch shifted by the
% current offset

%Set offset e.g.[-2,-1,0,1,2] and [2,2,2,2,2]

%Add edges
%image_board = padarray(image,[r+f r+f],'replicate','both');

distances = zeros(searchWindowSize,searchWindowSize);
%declare the number in search window to calculate SSD
for i = 1:searchWindowSize  %1-5
    for j = 1:searchWindowSize %1-5
        intensity_difference = image_board(row+f+i-f-1:row+2*r+f+i-f-1,col+f+j-f-1:col+2*r+f+j-f-1,:) - image_board(row+f:row+2*r+f,col+f:col+2*r+f,:);
        intensity_difference = intensity_difference.^2;
        distances (i,j) = sum(intensity_difference(:));
    end
end

distances = distances/(3*patchSize*patchSize);
end