function [ imgOutput ] = threshold( type,img )
%COLOR Summary of this function goes here
%   Detailed explanation goes here
%     H [0, 10]or[240, 255] [18, 45] [120, 175]
% S [40, 255] [148, 255] [127, 255]
% V [30, 255] [66, 255] [20, 255]
    if type == 1 % Red
        img = rgb2ycbcr(img); 

        Y  = img(:,:,1) ;
        Cb = img(:,:,2) ;
        Cr = img(:,:,3) ;

        Cr = (Cr >= 144);

        imgOutput = Y&Cb&Cr;

    elseif type == 2 % Yellow
        
        img = rgb2rgbn( img );
        
        R = img(:,:,1) ;
        G = img(:,:,2) ;
        B = img(:,:,3) ;
        
        R   = (R > 0.6700) & (R < 0.8800);
        G   = (G > 0.4800) & (G < 0.6900);
        B   = (B > 0.0000) & (B < 0.4000);
        
        imgOutput = R&G&B; 
%         img = im2uint8(rgb2hsv(img)); 
% 
%         H = img(:,:,1);
%         S = img(:,:,2);
%         V = img(:,:,3);
% 
%         % % Color Detection 
% 
%         % Yellow
%         Hy = (18<=H)&(H<=45);
%         Sy = S>=148;
%         Vy = V>=66;
% 
%         imgOutput = Hy&Sy&Vy; 

    else % Blue
        img = rgb2ycbcr(img); 

        Y  = img(:,:,1) ;
        Cb = img(:,:,2) ;
        Cr = img(:,:,3) ;

        Cb = (Cb >= 145);

        imgOutput = Y&Cb&Cr;
    end

end

