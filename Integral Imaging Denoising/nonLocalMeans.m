function [filtered] = nonLocalMeans(image, sigma, h, patchSize, windowSize)

    %Calculate f and raduis (for speed increase)
    f= (windowSize-1)/2;
    r = (patchSize-1)/2;
    sigma_squared = 2*sigma^2;
    
    %Obtain the size of the rquired image
    [rows,columns,channels]=size(image);
    
    %Three channels(better speed)
    for channel= 1:channels
        %Obtain an image with board
        image_board = padarray(image(:,:,channel),[f+r f+r],'replicate','both');
        %Patch-wise
        for row = 1: rows
            for column = 1: columns
                %Calculate distance(cost)
                distances = templateMatchingNaive(row, column,image_board,patchSize, windowSize,r,f);
                %Calculate weights
                [weight_sum,intensity_sum] = computeWeighting(row,column,distances,image_board, h, sigma_squared,windowSize,r);
                %Obtain the final pixel
                filtered(row,column,channel)= intensity_sum/weight_sum; 
            end
        end
    end

end