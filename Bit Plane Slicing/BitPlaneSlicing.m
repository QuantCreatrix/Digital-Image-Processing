%% Bit Plane Slicing
% Anubhav Rathore
%
% Input: Image
%
% Output: Compressed/Watermarked Image (can do encryption also for
% transmission purpose)

%% Defaults
clear all;
close all;
clc;

%% Image
I = imread("landscape.jpg");
Ig = rgb2gray(I);
figure, subplot(3,4, [1 2 3 4]), imshow(Ig), title("Original Grayscale Image");

%% Bit Plane Slicing 
bitPlanes = zeros(size(Ig,1), size(Ig, 2), 8); %L x W x Levels
for k = 1:8
    bitPlanes(:,:,k) = bitget(Ig,k);
    subplot(3,4,k+4), imshow(bitPlanes(:,:,k)), title(["Bit Plane: ", num2str(k-1)]);
end

%% Reconstruction 
reconstructedImage1 = zeros(size(Ig));  
for planes = 8:-1:2   
    reconstructedImage1 = reconstructedImage1 + ...
        bitPlanes(:,:,planes) * 2^(planes-1);
end
reconstructedImage1 = uint8(reconstructedImage1);

reconstructedImage2 = zeros(size(Ig));  
for planes = 8:-1:4   
    reconstructedImage2 = reconstructedImage2 + ...
        bitPlanes(:,:,planes) * 2^(planes-1);
end
reconstructedImage2 = uint8(reconstructedImage2);


figure; subplot(2,2,[1 2]), imshow(Ig), title("Original Grayscale Image"), xlabel("8 Bit Depth")
subplot(2,2,3), imshow(reconstructedImage1), title("Reconstructed Grayscale Image"), xlabel("7 Bit Depth (MSBs)");
subplot(2,2,4), imshow(reconstructedImage2), title("Reconstructed Grayscale Image"), xlabel("5 Bit Depth (MSBs)");

%% Watermarking
watermark = imread("Watermark.png");
W = rgb2gray(watermark);
W = imbinarize(W);
W = imresize(W, size(Ig));
I_watermarked = bitset(Ig, 6, W);
figure, subplot(1,2,1), imshow(Ig), title("Original Image");
subplot(1,2,2), imshow(I_watermarked), title("Watermarked Image");
