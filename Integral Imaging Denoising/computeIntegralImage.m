function [ii] = computeIntegralImage(image)

    %function computeIntegralImage(image)
    [rows,columns,channels] = size(image);
    
    %calculate Cumulative sum (column-wise)
    Cumulative_sum = zeros(size(image));
    ii = zeros(size(image));
    for channel = 1:channels
        for row = 1:rows
            for column = 1:columns
                if column == 1
                    Cumulative_sum(row,column,channel) = image(row,column,channel);
                else 
                    Cumulative_sum(row,column,channel) = Cumulative_sum(row,column - 1,channel) + image(row,column,channel);
                end
            end
        end
    end

    %calculate Cumulative sum
    for channel = 1:channels
        for row = 1:rows
            for column = 1:columns
                if row == 1
                    ii(row,column,channel) = Cumulative_sum(row,column,channel);
                else 
                    ii(row,column,channel) = ii(row - 1,column,channel) + Cumulative_sum(row,column,channel);
                end
            end
        end
    end
end