%% JPEG - Using MATLAB Tools
% Anubhav Rathore
% 
% Input: Image
% 
% Output: Compressed JPEG Image

%% Defaults
clc;
clear all;
close all;

%% Inputs
I = imread("landscape.png");

%% MATLAB JPEG
Q = [10 30 50 70 90];   % JPEG Quality 
filenames = strings(length(Q),1);

for k = 1:length(Q)
    filenames(k) = sprintf("cat_Q%d.jpg", Q(k));
    imwrite(I, filenames(k), 'jpg', 'Quality', Q(k));
end

%% Disk Size 
fprintf("\nJPEG File Size Comparison:\n");
fprintf("---------------------------------\n");

for k = 1:length(Q)
    fileinfo = dir(filenames(k));
    fprintf("Quality %3d : %8.2f KB\n", Q(k), fileinfo.bytes/1024);
end

%% Quality Factor vs File Size
file_sizes = zeros(length(Q),1);

for k = 1:length(Q)
    fileinfo = dir(filenames(k));
    file_sizes(k) = fileinfo.bytes/1024;
end

figure;
plot(Q, file_sizes, '-o', 'LineWidth', 2);
grid on;
xlabel("JPEG Quality Factor");
ylabel("File Size (KB)");
title("JPEG Quality vs Disk Size");


%% Different Quality Results Plot
figure("Name","JPEG Quality Comparison");

for k = 1:length(Q)
    subplot(2,3,k);
    imshow(imread(filenames(k)));
    title(sprintf("Q = %d", Q(k)));
end
