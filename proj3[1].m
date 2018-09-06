clc;
clear all;
close all;
img1= imread('newtest2.jpg');
% imshow(img1);
a= img1;
bw = a >100;
BW2 = bwareafilt(bw,[48 1800]); % test 2 
% BW2 = bwareafilt(bw,[120 1800]); % test 1 
% figure(3),imshow(BW2);
% figure,
% set(gca,'Color','w')
stats = regionprops(BW2,'BoundingBox');
 for k = 1 : length(stats)
  thisBB = stats(k).BoundingBox;
  tstimgs = imcrop(BW2,thisBB);
%   subplot(4,7,k), imshow(tstimgs)
 end
%  set(gca,'Color','w')
% suptitle(' the cropped images from the test image2')
 stats = regionprops(BW2,'BoundingBox');


%%

img2=rgb2gray(imread('letterW.jpg'));
% img2=(imread('letterR.png'));
  letbw = img2<100  ;
  letsts = regionprops(letbw,'BoundingBox','Area'); 
   if letsts(1).Area > letsts(2).Area
      letbb = letsts(1).BoundingBox;
      crplet= imcrop(letbw,[letbb(1) letbb(2) (letbb(3)+5) (letbb(4)+5)]);
   else 
      letbb = letsts(2).BoundingBox;
      crplet= imcrop(letbw,[letbb(1) letbb(2) (letbb(3)+5) (letbb(4)+5)]);
   end
% crplet=letbw;

  
%   figure,imshow(crplet)
%%
nodflg=1;
tt=1;
 for k = 1: length(stats)
  thisBB = stats(k).BoundingBox;
  tstimgscrp = imcrop(BW2,[thisBB(1) thisBB(2) (thisBB(3)+5) (thisBB(4)+5)]);
  [mm nn]=size(crplet);
  tstimgscrp=imresize(tstimgscrp,[mm nn]);
%   tstimgscrp=BW2;

 
 points1 = detectSURFFeatures(tstimgscrp);%,'MetricThreshold',50,'NumOctaves',2);%'NumScaleLevels',6);
 
 points2 = detectSURFFeatures(crplet);%,'MetricThreshold',50,'NumOctaves',2);%,'NumScaleLevels',10);
 [f1 valpt1] =extractFeatures(tstimgscrp,points1);%'Upright',false);
%  subplot(2,2,k),imshow(tstimgscrp); hold on;
%  plot(valpt1.selectStrongest(10));
 [f2 valpt2] =extractFeatures(crplet,points2);%'Upright',false);
 indexPairs =    matchFeatures(f1,f2);%,'MatchThreshold',60,'MaxRatio',0.25);%,'MatchThreshold',3 ,'MaxRatio',0.6);
 matchedPoints1 = valpt1(indexPairs(:,1),:);
 matchedPoints2 = valpt2(indexPairs(:,2),:);
 
 if ~isempty(indexPairs)
%    a=indexPairs  
%    mm(tt) = matchedPoints1 
%    mm2(tt)= matchedPoints2 
%    tt=tt+1;
   figure, showMatchedFeatures(tstimgscrp,crplet,matchedPoints1,matchedPoints2,'montage');
 else 
     nodflg = nodflg+1;
 end 
  
 end


%%
% 
% 
% 
% points1 = detectSURFFeatures(img1);%,'MetricThreshold',2,'NumOctaves',6,'NumScaleLevels',6);
% points2 = detectSURFFeatures(img2);%,'MetricThreshold',2,'NumOctaves',6,'NumScaleLevels',10);
% [f1 valpt1] =extractFeatures(img1,points1);%'Upright',false);
% [f2 valpt2] =extractFeatures(img2,points2);%'Upright',false);
% indexPairs =    matchFeatures(f1,f2);%,'MatchThreshold',3 ,'MaxRatio',0.6);
% matchedPoints1 = valpt1(indexPairs(:,1),:);
% matchedPoints2 = valpt2(indexPairs(:,2),:);
% figure; showMatchedFeatures(img2,img1,matchedPoints2,matchedPoints1,'montage');


