function [patchSum] = evaluateIntegralImage(distIntegral, row, col, patchSize)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii

r = (patchSize-1)/2;

%patchSum = L3 - L2 -L4 +L1
image_IntegralImage_board = padarray(distIntegral,[r+1 r+1],'replicate','both');

L3 = image_IntegralImage_board(row+patchSize,col+patchSize,1)+image_IntegralImage_board(row+patchSize,col+patchSize,2)+image_IntegralImage_board(row+patchSize,col+patchSize,3);
L2 = image_IntegralImage_board(row+patchSize,col,1)+image_IntegralImage_board(row+patchSize,col,2)+image_IntegralImage_board(row+patchSize,col,3);
L4 = image_IntegralImage_board(row,col+patchSize,1)+image_IntegralImage_board(row,col+patchSize,2)+image_IntegralImage_board(row,col+patchSize,3);
L1 = image_IntegralImage_board(row,col,1)+image_IntegralImage_board(row,col,2)+image_IntegralImage_board(row,col,3);
patchSum = L3- L2 - L4 + L1;

% L3 = image_IntegralImage_board(row+r+f,col+r+f,1)+image_IntegralImage_board(row+r+f,col+r+f,2)+image_IntegralImage_board(row+r+f,col+r+f,3);
% L2 = image_IntegralImage_board(row+r+f,col-1+f,1)+image_IntegralImage_board(row+r+f,col-1+f,2)+image_IntegralImage_board(row+r+f,col-1+f,3);
% L4 = image_IntegralImage_board(row-1+f,col+r+f,1)+image_IntegralImage_board(row-1+f,col+r+f,2)+image_IntegralImage_board(row-1+f,col+r+f,3);
% L1 = image_IntegralImage_board(row-1+f,col-1+f,1)+image_IntegralImage_board(row-1+f,col-1+f,2)+image_IntegralImage_board(row-1+f,col-1+f,3);
% patchSum = L3- L2 - L4 + L1;

end