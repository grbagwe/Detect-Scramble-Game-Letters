clc;
close all;

test1=imread('test_imge2.jpg');
rec =[259,124,21,22];
mm  = imcrop(test1,rec);
t1gr=rgb2gray(test1);
mm1=double(mm(:,:,1));
mm2= double(mm(:,:,2));
mm3=double(mm(:,:,3));

m1mean =mean(mean(mm1));
m1std = sqrt(var(var(mm1)));


m2mean =mean(mean(mm2));
m2std = sqrt(var(var(mm2)));

m3mean =mean(mean(mm3));
m3std = sqrt(var(var(mm3)));

n=5;
th11=m1mean -n*m1std;
th12=m1mean +n*m1std;

th21=m2mean -n*m2std;
th22=m2mean +(n-1)*m2std;
th31=m3mean -n*m3std;
th32=m3mean +n*m3std;
% 

ttim = (test1(:,:,1)>th11) & (test1(:,:,1)<th12) & ...
       (test1(:,:,2)>th21) & (test1(:,:,2)<th22) & ...
       (test1(:,:,3)>th31) & (test1(:,:,3)<th32) ;

 
   
 SE = strel('arbitrary',eye(4));
 
 imm =imerode(ttim,SE);
 
 st = regionprops(imm, 'BoundingBox' );
figure, imshow(imm)

 for k = 1 : length(st)
  thisBB = st(k).BoundingBox;
  rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
  'EdgeColor','r','LineWidth',2 )
end
immf =imfill(imm,'holes');
figure,imshow(immf)
title('immf')

newimg = uint8(immf) .* uint8(t1gr<70) *255;



se = strel('rectangle',[2 2])% strel('arbitrary',eye(5));
img22= imdilate(newimg,se);
% figure, imshow(img22)
imwrite(img22,'newtest2.jpg');
