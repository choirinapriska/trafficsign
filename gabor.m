clc, clear,close all;

A = imread('kobi.png');
A = imresize(A,0.25);
Agray = rgb2gray(A);
figure
imshow(A)

