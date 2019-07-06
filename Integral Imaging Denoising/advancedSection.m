%% Some parameters to set - make sure that your code works at image borders!

%Set parameters
patchSize = 9;
sigma = 21; % standard deviation (different for each image!)
h = 0.55; %decay parameter
windowSize = 5;

%Load image
image = imread('images\alleyNoisy_sigma20.png');
image = double(image);

imageReference = imread('images\alleyReference.png'); 


tic;
%TODO - Implement the non-local means function
filtered = nonLocalMeans(image, sigma, h, patchSize, windowSize);
toc

%Change to the format of unit8
filtered = uint8(filtered);
image = uint8(image);
%% Let's show your results!

%Show the denoised image
figure('name', 'NL-Means Denoised Image');
imshow(filtered);

%Show difference image
diff_image = abs(image - filtered);
figure('name', 'Difference Image');
imshow(double(diff_image ./ max(max((diff_image)))));

%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(image, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)