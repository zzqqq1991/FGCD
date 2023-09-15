function [ uv ] = getSIFTFlow( Im1,Im2 )
%GETSIFTFLOW 根据两幅图像得到SIFTFlow
% 
im1=imresize(imfilter(Im1,fspecial('gaussian',7,1.),'same','replicate'),1,'bicubic');
im2=imresize(imfilter(Im2,fspecial('gaussian',7,1.),'same','replicate'),1,'bicubic');

im1=im2double(im1);
im2=im2double(im2);
tic;
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
display('SIFT Flow time:');
toc

% return uv flow
clear uv;
uv(:,:,1)=vx;
uv(:,:,2)=vy;


end

