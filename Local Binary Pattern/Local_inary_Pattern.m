%% Local Binary Pattern
% Anubhav Rathore 

%% Defaults
clc;
clear;
close all;

%% Inputs, Variables, Constants
img = imread('Javanese-Cat.jpeg');   
img = rgb2gray(img);               
img = double(img);

[rows, cols] = size(img);

%% LBP 
LBP = zeros(rows-2, cols-2);

% LBP calculation
for i = 2:rows-1
    for j = 2:cols-1
        
        center = img(i,j);
        
        %neighbours comparison
        code = [ img(i-1,j-1) >= center,...
                 img(i-1,j)   >= center,...
                 img(i-1,j+1) >= center,...
                 img(i,j+1)   >= center,...
                 img(i+1,j+1) >= center,...
                 img(i+1,j)   >= center,...
                 img(i+1,j-1) >= center,...
                 img(i,j-1)   >= center ];
             
        % converting pattern into decimal
        weights = [1 2 4 8 16 32 64 128];
        LBP(i-1,j-1) = sum(code .* weights);
        
    end
end


LBP = uint8(LBP);

%% Plots
figure
subplot(1,2,1)
imshow(uint8(img))
title('Original Image')

subplot(1,2,2)
imshow(LBP)
title('LBP Image')