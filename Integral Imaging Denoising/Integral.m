function [distance] = Integral(row,coloum,image,patchSize, windowSize)

% num = 1;
% for i = 0:searchWindowSize - 1
%     for j = 0:searchWindowSize - 1
%         offsetsRows(num) = (1-searchWindowSize)/2 +i;
%         offsetsCols(num) = (1-searchWindowSize)/2 +j;
%         num = num + 1;
%     end
% end

    f= (windowSize-1)/2;
    r = (patchSize-1)/2;

[rows,columns,~] = size(image);


image_ssd = zeros(rows,columns,windowSize*windowSize);
for channel = 1:3
    image_single_channel = image(:,:,channel);
    offset = 1;
    %Calculate it from the first searchWindow pixel to the end pixel
    for i = -f:f
        image_boa = padarray(image_single_channel,[f f],'replicate','both');
        for j = -f:f
            image_board = image_boa(1+f+i:rows+f+i,1+f+j:columns+f+j);
            intensity_difference = image_board - image_single_channel;
            image_ssd(:,:,offset) = image_ssd(:,:,offset)+intensity_difference.^2;

            offset = offset+1;
        end
    end
end
        %integral image
        image_IntegralImage = computeIntegralImage(image_ssd);
        %sum_of_patch(sequence) = evaluateIntegralImage(image_IntegralImage, row, col, patchSize,searchWindowSize);
        
        %calculate ssd
        sum_of_patch = evaluateIntegralImage02(image_IntegralImage(:,:,:), row, coloum, r,f)/(3*patchSize*patchSize);  
        
        %change the sequence of it from 1 by windowSize*windowSize to
        %windowSize by windowSize
        distance = zeros(windowSize,windowSize);
        sequence = 1;
        for Row = 1:windowSize    
                 for Column = 1:windowSize
                     distance(Row,Column) = sum_of_patch(sequence);
                     sequence = sequence + 1;
                 end
        end

%sum_of_patch = sum_of_patch/(3*patchSize*patchSize);

    
end