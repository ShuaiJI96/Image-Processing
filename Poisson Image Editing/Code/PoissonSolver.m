function ResultImg = PoissonSolver(A,SourceR,Row,Col,Row_source,Col_source,Target,boundary)

    tempImage = padarray(SourceR,[1 1],'replicate','both');
    div = 4*tempImage - circshift(tempImage,1,1) - circshift(tempImage,-1,1) - circshift(tempImage,1,2) - circshift(tempImage,-1,2);

    %Obtain the divergence b
    b = zeros(size(Row,1),1);
    for i = 1:size(Row,1)
        b(i) = div(Row_source(i)+1,Col_source(i)+1);
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