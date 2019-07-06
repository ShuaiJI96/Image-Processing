function [Col_source,Row_source] = SizeSource(SourceMask,row_source,col_source)

    %Extract boundary
    TargBoundry = bwboundaries(SourceMask,8);
    TargBoundry = TargBoundry{1};
    boundary = zeros(row_source,col_source);
    for i = 1:size(TargBoundry)
        boundary(TargBoundry(i,1),TargBoundry(i,2)) = 1;
    end

    %Substitute boundary
    SourceMask = SourceMask - boundary;

    %Find selected region's cols and rows
    [Col_source,Row_source] = find(transpose(SourceMask));

end