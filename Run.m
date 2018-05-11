% Detection and Recognition of Traffic Signs Based on HSV Vision Model and
% Shape features - http://www.jcomputers.us/vol8/jcp0805-35.pdf

clc, clear, close all;

warning('off', 'Images:initSize:adjustingMag');
nmFold = 'dataset/Blue/';
fold   = dir(fullfile(nmFold,'*.jpg'));

colorArr = {'Red' 'Yellow' 'Blue'};

for k = 1:size(fold,1)
    
    disp(['=======' num2str(k) '============']);
    img = imread([nmFold fold(k).name]);
    img = imresize(img, [400, 600]);
    
    figure('units','normalized','outerposition',[0 0 1 1],'visible','on');
    subplot(2,2,1),imshow(img), title('Original');
    
%     for i = 1:3
        thresImg = threshold( 3,img);
        
        subplot(2,2,2),imshow(thresImg), title(['Img ' colorArr(3)])
        
        labeledImage1   = logical(bwlabel(thresImg,8)); % memberikan label pada value image. 
        blobStructure   = regionprops(labeledImage1,'all'); % mengukur properti dari setiap region yang telah dilabeli 
        blobSize1       = [blobStructure.Area]; % ambil data Area dari regionProps
        specialBlobs    = find(blobSize1 >= 100 ); % ambil max value dari variable  blobSize1
        
        if(specialBlobs > 0)
            for l = 1:size(specialBlobs,2)
                show = blobStructure(specialBlobs);                
%                 disp([ num2str(show(l).BoundingBox(3)) ]);
%                 uint8(abs(STATS(i).BoundingBox(3)-STATS(i).BoundingBox(4)) < 0.1);
                
                subplot(2,2,i+1),imshow(img), title(['Img ' colorArr(i)]), hold on
                for a = 1 : size(show,1)
                    rectangle('Position', ...
                    [show(a).BoundingBox(1),... 
                     show(a).BoundingBox(2),...
                     show(a).BoundingBox(3),show(a).BoundingBox(4)], 'EdgeColor','r','LineWidth',2 );
                 
%                     text(show(a).BoundingBox(1),show(a).BoundingBox(2),num2str(a));
                    
%                     imcrop(img,[show(a).BoundingBox(1),... 
%                      show(a).BoundingBox(2),...
%                      show(a).BoundingBox(3),show(a).BoundingBox(4)])
%                     if i == 3
%                         disp([num2str(a) '. '...
%                             num2str(show(a).BoundingBox(1)) ',',...
%                             num2str(show(a).BoundingBox(2)) ',',...
%                             num2str(show(a).BoundingBox(3)) ',',...
%                             num2str(show(a).BoundingBox(4))])
%                     end
                end
                hold off;
            end
        end
    end
    
%     if(k > 7)
%         return
%     end
    
%     pause(0.01);
end