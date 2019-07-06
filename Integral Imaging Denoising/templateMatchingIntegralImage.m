function [image_IntegralImage] = templateMatchingIntegralImage(image,~, windowSize)

    f= (windowSize-1)/2;

    [rows,columns,channels] = size(image);

    %Need a three order matrix
    image_ssd = zeros(rows,columns,windowSize*windowSize);
    for channel = 1:channels
        image_single_channel = image(:,:,channel);
        offset = 1;
        for i = -f:f
            image_boa = padarray(image_single_channel,[f f],'replicate','both');
            for j = -f:f
                image_board = image_boa(1+f+i:rows+f+i,1+f+j:columns+f+j);
                intensity_difference = image_board - image_single_channel;
                image_ssd(:,:,offset) = image_ssd(:,:,offset)+intensity_difference.^2;
        %         for Row = 1:rows    
        %             for Column = 1:columns
        %                 image_ssd(Row,Column,channel) = (image_board(Row+(searchWindowSize-1)/2+offsetsRows(sequence),Column+(searchWindowSize-1)/2+offsetsCols(sequence),channel) - image(Row,Column,channel))^2;
        %             end
        %         end
            offset = offset+1;
            end
        end
    end
            %Use the function 'computeIntegralImage' to calculate the
            %integral image.(pixel-wise)
            image_IntegralImage = computeIntegralImage(image_ssd);
    %         %sum_of_patch(sequence) = evaluateIntegralImage(image_IntegralImage, row, col, patchSize,searchWindowSize);
    %         sum_of_patch = evaluateIntegralImage(image_IntegralImage(:,:,:), 10, 10, 5,5)/75;  
    %         
    %         distance = zeros(windowSize,windowSize);
    %         sequence = 1;
    %         for Row = 1:windowSize    
    %                  for Column = 1:windowSize
    %                      sum_of_patch = evaluateIntegralImage(image_IntegralImage(:,:,sequence), 10, 10, 5,5)/75;  
    %                      distance(Row,Column) = sum_of_patch;
    %                      sequence = sequence +1;
    %                  end
    %         end
    % 
    % sum_of_patch = sum_of_patch/(3*patchSize*patchSize);

    
end