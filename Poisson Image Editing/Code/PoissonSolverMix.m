function ResultImg = PoissonSolverMix(A,SourceR,Row,Col,Row_source,Col_source,Target,boundary)

    tempSource = padarray(SourceR,[1 1],'replicate','both');
    div_source = 4*tempSource - circshift(tempSource,1,1) - circshift(tempSource,-1,1) - circshift(tempSource,1,2) - circshift(tempSource,-1,2);
    abs_source = abs(div_source);
    tempTarget = padarray(Target,[1 1],'replicate','both');
    div_target = 4*tempTarget - circshift(tempTarget,1,1) - circshift(tempTarget,-1,1) - circshift(tempTarget,1,2) - circshift(tempTarget,-1,2);
    abs_target = abs(div_target);
    
    %Obtain the divergence b
    b = zeros(size(Row,1),1);
    for i = 1:size(Row,1)
        if abs_target(Row(i)+1,Col(i)+1) > abs_source(Row_source(i)+1,Col_source(i)+1)
            b(i) = div_target(Row(i)+1,Col(i)+1);
        else
            b(i) = div_source(Row_source(i)+1,Col_source(i)+1);
        end
        
        if boundary(Row(i)+1,Col(i)) == 1
            b(i) = b(i) + Target(Row(i)+1,Col(i));
        end
        if boundary(Row(i)-1,Col(i)) == 1
            b(i) = b(i) + Target(Row(i)-1,Col(i));
        end
        if boundary(Row(i),Col(i)+1) == 1
            b(i) = b(i) + Target(Row(i),Col(i)+1);
        end
        if boundary(Row(i),Col(i)-1) == 1
            b(i) = b(i) + Target(Row(i),Col(i)-1);
        end
    end

    %Calculate intensity
    x = A\b;
    ResultImg = Target;
    for i=1:size(Row,1)
        ResultImg(Row(i),Col(i)) = x(i);
    end
    ResultImg = uint8(ResultImg);
end


