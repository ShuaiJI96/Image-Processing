function distances = templateMatchingNaive(row, col,...
    image_board,patchSize, searchWindowSize,r,f)


distances = zeros(searchWindowSize,searchWindowSize);
%declare the number in search window to calculate SSD
for i = 1:searchWindowSize  %1-5
    for j = 1:searchWindowSize %1-5
        intensity_difference = image_board(row+f+i-f-1:row+2*r+f+i-f-1,col+f+j-f-1:col+2*r+f+j-f-1) - image_board(row+f:row+2*r+f,col+f:col+2*r+f);
        intensity_difference = intensity_difference.^2;
        distances (i,j) = sum(intensity_difference(:));
    end
end

distances = distances/(patchSize*patchSize);
end