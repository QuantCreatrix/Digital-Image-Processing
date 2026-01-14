%% Basics of Image Processing 14 Jan 2026
% Anubhav Rathore
% Input: Image
% Output: Image

%% Defaults
clc;
clear all;
close all;

%% Image Read
I = imread("landscape.jpg"); 
imshow(I);
figure;

%% GrayScale
Ig = rgb2gray(I); 
imshow(Ig);

%% Red components
Ired = I;
Ired(:,:,2) = 0;
Ired(:,:,3) = 0;
figure;
imshow(Ired);

%% Black and White
Ibw = Ig > 80;
figure;
imshow(Ibw);

%% Histogram Equalisation
Ieq = histeq(Ig);
figure;
imshow(Ieq);