%% JPEG2000 Style Compression - DWT Based
% Anubhav Rathore
%
% Input  : RAW Image
% Output : Reconstructed Image using DWT (JPEG2000 concept)
%
% Notes:
% - Haar Wavelet
% - 2-level DWT on Y channel
% - Chroma subsampling (4:2:0)
% - Threshold-based coefficient suppression
% - No blocking artifacts

%% Defaults
clear all;
clc;
close all;

%% 1. Inputs, Variables, Constants
I = imread("cat.png");

figure("Name","Original Image");
imshow(I);
title("Original RGB Image");

%% 2. RGB -> YCbCr 
Iycbcr = rgb2ycbcr(I);

Y  = Iycbcr(:,:,1);
Cb = Iycbcr(:,:,2);
Cr = Iycbcr(:,:,3);

figure("Name","Color Space Conversion");
subplot(1,2,1), imshow(I), title("RGB Color Space");
subplot(1,2,2), imshow(Iycbcr), title("YCbCr Color Space");

%% 3. Image Size Adjustment (Even dimensions for DWT)
[H,W] = size(Y);

H2 = floor(H/2)*2;
W2 = floor(W/2)*2;

Y  = Y(1:H2, 1:W2);
Cb = Cb(1:H2, 1:W2);
Cr = Cr(1:H2, 1:W2);

%% 4. Chroma Subsampling (4:2:0)
Cb_ds = Cb(1:2:end, 1:2:end);
Cr_ds = Cr(1:2:end, 1:2:end);

figure("Name","Chroma Subsampling");
subplot(1,3,1), imshow(Y), title("Y - Luminance");
subplot(1,3,2), imshow(Cb_ds), title("Cb - Subsampled");
subplot(1,3,3), imshow(Cr_ds), title("Cr - Subsampled");

%% 5. Convert Y to Double
Y = double(Y);

%% 6. Level-1 2D HAAR DWT
[LL1, LH1, HL1, HH1] = dwt2(Y, 'haar');

figure("Name","Level-1 DWT Subbands");
subplot(2,2,1), imagesc(LL1), colormap gray, title("LL1");
subplot(2,2,2), imagesc(LH1), colormap gray, title("LH1");
subplot(2,2,3), imagesc(HL1), colormap gray, title("HL1");
subplot(2,2,4), imagesc(HH1), colormap gray, title("HH1");

%% 7. Level-2 DWT on LL1
[LL2, LH2, HL2, HH2] = dwt2(LL1, 'haar');

figure("Name","Level-2 DWT Subbands");
subplot(2,2,1), imagesc(LL2), colormap gray, title("LL2");
subplot(2,2,2), imagesc(LH2), colormap gray, title("LH2");
subplot(2,2,3), imagesc(HL2), colormap gray, title("HL2");
subplot(2,2,4), imagesc(HH2), colormap gray, title("HH2");

%% 8. Thresholding (JPEG2000-style Quantization)
T1 = 20;   % Threshold for level-1 details
T2 = 30;   % Threshold for level-2 details

LH1(abs(LH1) < T1) = 0;
HL1(abs(HL1) < T1) = 0;
HH1(abs(HH1) < T1) = 0;

LH2(abs(LH2) < T2) = 0;
HL2(abs(HL2) < T2) = 0;
HH2(abs(HH2) < T2) = 0;

%% 9. Inverse DWT for Reconstruction
LL1_rec = idwt2(LL2, LH2, HL2, HH2, 'haar');
Y_rec   = idwt2(LL1_rec, LH1, HL1, HH1, 'haar');

Y_rec = uint8(min(max(Y_rec,0),255));

%% 10. Chroma Upsampling (4:2:0 -> 4:4:4)
Cb_rec = imresize(Cb_ds, 2, 'bilinear');
Cr_rec = imresize(Cr_ds, 2, 'bilinear');

Cb_rec = uint8(Cb_rec(1:H2,1:W2));
Cr_rec = uint8(Cr_rec(1:H2,1:W2));

%% 11. Recombine channels and YCbCr -> RGB
Iycbcr_rec = cat(3, Y_rec, Cb_rec, Cr_rec);
I_rec = ycbcr2rgb(Iycbcr_rec);

%% 12. Final Visual Comparison
figure("Name","JPEG2000 (DWT) Result");
subplot(1,2,1), imshow(I(1:H2,1:W2,:)), title("Original Image");
subplot(1,2,2), imshow(I_rec), title("JPEG2000 Reconstructed Image");

%% 13. Quality Metrics
mse = mean((double(I(1:H2,1:W2,:)) - double(I_rec)).^2, 'all');
psnr_val = 10*log10(255^2 / mse);

fprintf("MSE  = %.4f\n", mse);
fprintf("PSNR = %.2f dB\n", psnr_val);
