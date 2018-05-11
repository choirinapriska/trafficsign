%% just test
close all;clear;
m=zeros(200,300);
m=logical(m);
m(50,30:190)=1;
m(100,30:190)=1; 
m(50:100,30)=1;
m(50:100,190)=1;
%m=imrotate(m,45);
stats=regionprops(m,'BoundingBox');
bx = stats.BoundingBox;
m=imcrop(m,bx);
m=padarray(m,[3 3]);
figure(1),imagesc(m)
 [H, T, R] = hough(m);
               figure(2)
               imshow(imadjust(mat2gray(H)),'XData',T,'YData',T,...
                   'InitialMagnification','fit');
               title('Hough Transform of  Image');
               xlabel('\theta'), ylabel('\rho');
               axis on, axis normal, hold on;
               colormap(hot);
               Hv=H(:);
               mxH = 0.2*max(Hv);
               ii=find(Hv>=mxH);
               [aa bb]   =  ind2sub(size(H),ii);
               figure(4),imagesc(T,R,H),hold on,plot(T(bb),R(aa),'gs','MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5]);