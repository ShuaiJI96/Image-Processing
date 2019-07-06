function [weight_sum,intensity_sum] = computeWeighting(row,column,distance,image_board, h, sigma_squared,windowSize,r)
    
    %Calculate weight and intensity in each patch
    for off_row = 1: windowSize
        for off_col = 1:windowSize
            weight(off_row,off_col)= exp(-(max(distance(off_row,off_col)-sigma_squared,0))/ h^2);
            intensity(off_row,off_col)= weight(off_row,off_col)*image_board(row+off_row-1+r,column+off_col-1+r);
        end
    end
    
    %Calculate sums of weight and intensity in each patch
    weight_sum=sum(weight(:));
    intensity_sum=sum(intensity(:));
end