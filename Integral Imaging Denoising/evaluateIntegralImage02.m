function [patchSum] = evaluateIntegralImage02(distIntegral, row, col, r,f)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii

%patchSum = L3 - L2 -L4 +L1
image_IntegralImage_board = padarray(distIntegral,[r+f r+f],'replicate','both');



L3 = image_IntegralImage_board(row+2*r+f,col+2*r+f,:);
L2 = image_IntegralImage_board(row+2*r+f,col-1+f,:);
L4 = image_IntegralImage_board(row-1+f,col+2*r+f,:);
L1 = image_IntegralImage_board(row-1+f,col-1+f,:);
patchSum = L3- L2 - L4 + L1;

% L3 = distIntegral(row,col);
% L2 = distIntegral(row,col-5);
% L4 = distIntegral(row-5,col);
% L1 = distIntegral(row-5,col-5);
% patchSum = L3- L2 - L4 + L1;

end