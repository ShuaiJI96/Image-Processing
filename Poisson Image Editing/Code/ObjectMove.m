function MaskTarget = ObjectMove(position_in_target,GreyTarget,SourceMask)

    [Rows, Cols] = size(GreyTarget);
    [row, col] = find(SourceMask);
    %Calculate the size of mask in source
    start_position = [min(col), min(row)];
    end_position   = [max(col), max(row)];
    frame_size  = end_position - start_position;
    %Make sure the frame does not exceed the scope of the target diagram
    if (frame_size(1) + position_in_target(1) > Cols)
        position_in_target(1) = Cols - frame_size(1);
    end
    if (frame_size(2) + position_in_target(2) > Rows)
        position_in_target(2) = Rows - frame_size(2);
    end
    MaskTarget = zeros(Rows, Cols);
    MaskTarget(sub2ind([Rows, Cols], row - start_position(2) + position_in_target(2), ...
     col - start_position(1) + position_in_target(1))) = 1;

end