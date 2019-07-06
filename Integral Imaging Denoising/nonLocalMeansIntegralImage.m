function [filtered] = nonLocalMeansIntegralImage(image, sigma, h, patchSize, windowSize)

    %Calculate f and raduis (for speed increase)
    f= (windowSize-1)/2;
    r = (patchSize-1)/2;
    sigma_squared = 2*sigma^2;
    
    %Obtain the size of the image
    [rows,columns,~] = size(image);
    
    weight_sum = zeros(size(image));
    intensity_sum = zeros(size(image));
    %offset wise
    for off_row = -f:f
        for off_col = -f:f
            %Board the image
            image_board  = padarray(image,[f f],'replicate','both');
            imagerow = (1:rows);
            imagecol = (1:columns);
            imageoffset = image_board(f+imagerow+off_row,f+imagecol+off_col,:);
            intensity_difference = (image - imageoffset).^2;
            %Calculate integral of the image
            distIntegral = computeIntegralImage(intensity_difference);
            %Obtain ssd of the whole image (fixed offset)
            distance = evaluateIntegralImage(distIntegral,imagerow,imagecol,patchSize)/ (3*patchSize^2);
            %distance = evaluateIntegralImage02(distIntegral,imagerow,imagecol,r)/ (3*patchSize^2);
            %Calculate weights
            for row = 1:rows
                for column = 1:columns
                    w(row,column) = exp(-(max(distance(row,column)-sigma_squared,0))/ h^2);
                end
            end
            weight_sum = weight_sum +w;
            intensity_sum = intensity_sum + w .* imageoffset;
        end
    end
    %Obtain the final image ( divide C(p) )
    filtered = intensity_sum ./ weight_sum;
 end   
    
            