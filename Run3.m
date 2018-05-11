clc, clear, close all;

warning('off', 'Images:initSize:adjustingMag');
nmFold = 'dataset/BLUE/';
fold   = dir(fullfile(nmFold,'*.png'));

colorArr = {'Red' 'Yellow' 'Blue'};
colorCode = {'red' 'yellow' 'blue'};

for f = 1: size(fold,1)
    disp(['==============' num2str(f) '===================']);
    img = imread([nmFold fold(f).name]);
%     img = imresize(img, [400, 600]);
    
    figure('units','normalized','outerposition',[0 0 1 1],'visible','on');
%     subplot(2,2,1),imshow(img), title(['Original - ' fold(f).name]);
%     subplot(2,2,c+1),imshow(img), title(['Img ' colorArr(c)]), hold on
    imshow(img),hold on;
    for c = 1:3
        thresImg = threshold( c,img);
        bw = bwareaopen(thresImg,30);
        se = strel('disk',2);
        bw = imclose(bw,se);

        bw = imfill(bw,'holes');

        [B,L] = bwboundaries(bw,'noholes');
        
        stats = regionprops(L,'All');
        blobSize1       = [stats.Area];  
        specialBlobs    = find(blobSize1 >= 100);
       
        show = stats(specialBlobs);     

        for a = 1 : size(show,1)
            boundary = B{a};            
            delta_sq = diff(boundary).^2;
            perimeter = sum(sqrt(sum(delta_sq,2)));
            area = stats(a).Area;
            eccentricity = stats(a).Eccentricity;
            metric = 4*pi*area/perimeter^2;
            
            rect = [show(a).BoundingBox(1),show(a).BoundingBox(2),show(a).BoundingBox(3),show(a).BoundingBox(4)];
%             rectangle('Position', rect, 'EdgeColor',colorCode{c},'LineWidth',2 );
            if metric<0.89
                if eccentricity>0.04 && eccentricity <0.05
                else
                    text(rect(1),rect(2),['3 - ' num2str(a)],'FontSize',11, 'Color','white'); 
                    rectangle('Position', rect, 'EdgeColor',colorCode{c},'LineWidth',2 );                    
%                     disp(['3 - ' num2str(a) ' |'  num2str(metric) ' | ' num2str(eccentricity)]);
                end
            else
                text(rect(1),rect(2),['4 - ' num2str(a)],'FontSize',11,'Color','white'); 
                rectangle('Position', rect, 'EdgeColor',colorCode{c},'LineWidth',2 );
%                 disp(['4 - ' num2str(a) ' |'  num2str(metric) ' | ' num2str(eccentricity)]);
            end 
        end
        hold off;
       
%         subplot(2,2,c+1),imshow(L), title(colorArr(c));
    end
end