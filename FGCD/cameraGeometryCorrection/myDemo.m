sourceDir = './yard2/'

im1=imread([sourceDir, '0.bmp']);
im2=imread([sourceDir,'1.bmp']);

im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),1,'bicubic');
im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),1,'bicubic');

im1=im2double(im1);
im2=im2double(im2);
tic;
%figure;imshow(im1);figure;imshow(im2);
cellsize=3;
gridspacing=1;

addpath(fullfile(pwd,'mexDenseSIFT'));
addpath(fullfile(pwd,'mexDiscreteFlow'));

sift1 = mexDenseSIFT(im1,cellsize,gridspacing);
sift2 = mexDenseSIFT(im2,cellsize,gridspacing);

SIFTflowpara.alpha=2*255;
SIFTflowpara.d=40*255;
SIFTflowpara.gamma=0.005*255;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=2;
SIFTflowpara.topwsize=10;
SIFTflowpara.nTopIterations = 60;
SIFTflowpara.nIterations= 30;

[vx,vy,energylist]=SIFTflowc2f(sift1,sift2,SIFTflowpara);
toc
warpI2=warpImage(im2,vx,vy);
imwrite(warpI2,[sourceDir,'warpedIm2.bmp']);
figure;imshow(im1);figure;imshow(warpI2);

% smallIm1 = imread('0-small.bmp');
% smallIm2 = imread('1-small.bmp');
% warpIm2_flow = warpFLColor(smallIm1,smallIm2,vx,vy);
% imwrite(warpIm2_flow,'warpedIm2_flow.bmp');

% display flow
clear flow;
flow(:,:,1)=vx;
flow(:,:,2)=vy;
figure;imshow(flowToColor(flow,8));
imwrite(flowToColor(flow,8),[sourceDir,'flow.bmp']);

return;


