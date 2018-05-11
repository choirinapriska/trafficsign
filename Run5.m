clc, clear, close all;

warning('off', 'Images:initSize:adjustingMag');
nmFold = 'dataset/blue/';
fold   = dir(fullfile(nmFold,'*.png'));

colorArr = {'Red' 'Yellow' 'Blue'};
colorCode = {'red' 'yellow' 'blue'};

rects = cell(size(fold,1),4, 3 );

for f = 1: size(fold,1)
    disp(['==============' num2str(f) '===================']);
%     img = imread([nmFold fold(f).name]);
    img = imread([nmFold '10.png']);
    
    figure('units','normalized','outerposition',[0 0 1 1],'visible','on');
%     subplot(2,2,1),imshow(img), title(['Original - ' fold(f).name]);
%     subplot(2,2,c+1),imshow(img), title(['Img ' colorArr(c)]), hold on
    imshow(img),hold on;
    for c = 1:3
        thresImg = threshold( c,img);
        bw = bwareaopen(thresImg,40);
        se = strel('disk',2);
        bw = imclose(bw,se);
        bw = imfill(bw,'holes');

        [B,L]           = bwboundaries(bw,'noholes');        
        stats           = regionprops(L,'All');
        blobSize1       = [stats.Area];  
        specialBlobs    = find(blobSize1 >= 100);
        show            = stats(specialBlobs);     
        
        for a = 1 : size(show,1) 
            rect = [show(a).BoundingBox(1),show(a).BoundingBox(2),show(a).BoundingBox(3),show(a).BoundingBox(4)];
            
            luas = rect(3) * rect(4);
            disp([num2str(f) ' - ' colorArr{c} ' - ' num2str(a) ' - ' num2str(rect(3)) '    ' num2str(rect(4)) ' = ' num2str(luas) ])
            if luas >= 1295 && luas <= 14720                
%                 disp([num2str(f) ' - ' colorArr{c} ' - ' num2str(a) ' - ' num2str(rect(3)) '    ' num2str(rect(4)) ])
                text(rect(1),rect(2),num2str(a),'FontSize',11, 'Color','yellow'); 
                rectangle('Position', rect, 'EdgeColor',colorCode{c},'LineWidth',2 );
            end
        end
        hold off;
    end
    return;
%     saveas(gcf,['result/' num2str(f) '.png']);
end