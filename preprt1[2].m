clc;
clear all;
close all;
 test1=imread('test_image1.jpg');
 t1gr =rgb2gray(test1);
 figure,subplot(1,2,1) ,imshow(test1);% colormap gray(255);
subplot(1,2,2),imagesc(t1gr); colormap gray(255);
figure,  his =histogram(rgb2gray(test1));
%%
%  
  % the thresold from the image is lower than 210;
%   
  tstn= (160<t1gr) & (t1gr<210);
 figure,imagesc(tstn), colormap gray(255);

%%
se = strel('line',5,90);
erodedBW = imdilate(tstn,se);
 figure(10),imagesc(erodedBW), colormap gray(255);
%%
se = strel('line',1,90);
erodedBW =imerode(erodedBW,se);


 figure(10),imagesc(erodedBW), colormap gray(255);
%%
imf= imfill(erodedBW,'holes');
 figure(10),imagesc(imf), colormap gray(255);
%%
 figure(11),imagesc(uint8(t1gr<150)), colormap gray(255);


 %%
newimg = uint8(imf) .* uint8(t1gr<150) *255;
 figure(12),imagesc(newimg), colormap gray(255);
 
  st = regionprops(newimg, 'BoundingBox' );
figure, imshow(newimg)

 for k = 1 : length(st)
  thisBB = st(k).BoundingBox;
  rectangle('Position', [thisBB],...
  'EdgeColor','r','LineWidth',2 )
end
 imwrite(newimg,'newtest1.jpg');

