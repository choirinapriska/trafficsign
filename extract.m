function [show,BWnoBord] = extract( h, img, color )
%EXTRACT Summary of this function goes here
%   Detailed explanation goes here

    labeledImage1   = logical(bwlabel(h,8)); % memberikan label pada value image. 
    blobStructure   = regionprops(labeledImage1,'BoundingBox','Area'); % mengukur properti dari setiap region yang telah dilabeli 
    blobSize1       = [blobStructure.Area]; % ambil data Area dari regionProps
    specialBlobs    = find(blobSize1 >= 50); % ambil max value dari variable  blobSize1

    if(specialBlobs > 0)
        [sbR ,sbC] = size(specialBlobs);

        for i = 1:sbC
            singleBlob = ismember(labeledImage1, specialBlobs(1,i));  % check exist
            singleBlobComp = imcomplement(singleBlob); 
            BWnoBord = imclearborder(singleBlobComp,4);

           subplot(2,2,color), imshow(img); title(['Color : ' num2str(color) ]),hold on
            show = blobStructure(specialBlobs);
            for j = 1: size(show,1)
                
                rectangle('Position', ...
                    [show(j).BoundingBox(1),... 
                     show(j).BoundingBox(2),...
                     show(j).BoundingBox(3),show(j).BoundingBox(4)], 'EdgeColor','r','LineWidth',2 )
            end
            hold off;
        end
    end
end

