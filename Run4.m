clc, clear, close all;

warning('off', 'Images:initSize:adjustingMag');
nmFold = 'dataset/blue/';
fold   = dir(fullfile(nmFold,'*.jpg'));

colorArr = {'Red' 'Yellow' 'Blue'};
colorCode = {'red' 'yellow' 'blue'};

% for f = 1: size(fold,1)
%     disp(['==============' num2str(f) '===================']);
%     img = imread([nmFold fold(f).name]);
    img = imread([nmFold 'DSCN0439.jpg']);
    img = imresize(img, [400, 600]);
    
    figure('units','normalized','outerposition',[0 0 1 1],'visible','on');
%     subplot(2,2,1),imshow(img), title(['Original - ' fold(f).name]);
%     subplot(2,2,c+1),imshow(img), title(['Img ' colorArr(c)]), hold on
%     imshow(img),hold on;
    for c = 1:3
        thresImg = threshold( c,img);
        bw = bwareaopen(thresImg,30);
        se = strel('disk',2);
        bw = imclose(bw,se);

        bw = imfill(bw,'holes');

        [B,L] = bwboundaries(bw,'noholes');
        
        imshow(L)
        hold on
        obj =visboundaries(B);
    end
% end