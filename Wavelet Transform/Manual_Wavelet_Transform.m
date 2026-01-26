%% Manual Wavelt Transform 
% Anubhav Rathore

%% Defaults
clear all;
close all;
clc;

%% Image
I = imread("ironman.jpg");
figure, subplot(2,4,[1 2]), imshow(I), title("Original Image");
Ig = rgb2gray(I);
subplot(2,4,[3 4]), imshow(Ig),title("Grayscale Image");

%% Function
function [LL, LH, HL, HH] = haar_wavelet_transform_single(img)
    img = double(img);
    [rows, cols] = size(img);
    rows = rows - mod(rows, 2);
    cols = cols - mod(cols, 2);
    img = img(1:rows, 1:cols);
    
    LL = zeros(rows/2, cols/2);
    LH = zeros(rows/2, cols/2);
    HL = zeros(rows/2, cols/2);
    HH = zeros(rows/2, cols/2);
    
    for i = 1:2:rows
        for j = 1:cols
            avg = (img(i, j) + img(i+1, j)) / sqrt(2);
            diff = (img(i, j) - img(i+1, j)) / sqrt(2);
            img(i, j) = avg;
            img(i+1, j) = diff;
        end
    end
    
    for j = 1:2:cols
        for i = 1:rows
            avg = (img(i, j) + img(i, j+1)) / sqrt(2);
            diff = (img(i, j) - img(i, j+1)) / sqrt(2);
            img(i, j) = avg;
            img(i, j+1) = diff;
        end
    end
    
    LL = img(1:2:rows, 1:2:cols);
    HL = img(2:2:rows, 1:2:cols);
    LH = img(1:2:rows, 2:2:cols);
    HH = img(2:2:rows, 2:2:cols);
end


%% Results
[LL, LH, HL, HH] = haar_wavelet_transform_single(Ig);
LLs = uint8(LL);
subplot(2,4,5), imshow(LLs),title("LL");
LHs = uint8(LH);
subplot(2,4,6), imshow(LHs), title("LH");
HLs = uint8(HL);
subplot(2,4,7), imshow(HLs),title("HL");
HHs = uint8(HH);
subplot(2,4,8), imshow(HHs),title("HH");


