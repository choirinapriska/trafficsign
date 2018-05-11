function [ rgbn ] = rgb2rgbn( rgbImg )
%RGB2RGBN Summary of this function goes here
%   Detailed explanation goes here

    rgbImage = double(rgbImg);

    redChannel   = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel  = rgbImage(:, :, 3);

    magnitudeImage = sqrt(redChannel .^2 + greenChannel .^2 + blueChannel.^2);

    rgbn(:,:,1)   = redChannel ./ magnitudeImage; % red
    rgbn(:,:,2)   = greenChannel ./ magnitudeImage; % green
    rgbn(:,:,3)   = blueChannel ./ magnitudeImage; % blue

end

