%% Wavelet Transform
% Anubhav Rathore 
% 
% Transform based compression

%% Defaults
clc;
clear all;
close all;

%% Image to Grayscale
I = imread("ironman.jpg");
subplot(2,4,[1 2]);
imshow(I); title("Original Image");
Ig = rgb2gray(I);
subplot(2,4,3);
imshow(Ig); title("Grayscale Image")

%% Wavelet Transform
[Iabsolute, Ivertical, Ihorizontal, Idiagonal] = dwt2(Ig, "haar");
subplot(2,4,5);
IabsoluteS = uint8(Iabsolute); imshow(IabsoluteS); title("Absolute");

IverticalS = uint8(Ivertical);
subplot(2,4,6); imshow(IverticalS); title("Vertical");

IhorizontalS = uint8(Ihorizontal);
subplot(2,4,7); imshow(IhorizontalS); title("Horizontal");

IdiagonalS = uint8(Idiagonal);
subplot(2,4,8); imshow(IdiagonalS); title("Diagonal");

%% Reconstruction
reconsI = idwt2(Iabsolute, Ihorizontal, Ivertical, Idiagonal, "haar");
reconsI = uint8(reconsI);
subplot(2,4,4), imshow(reconsI); title("Reconstructed Image");
