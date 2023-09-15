function uv = SIFTFlow_Multiple(Img1s,Img2s, flowparam)
%SIFTFLOW_MULTIPLE 多张图做flow,SIFT采用1对1的形式，返回的uv可以将Img2s中的图warped到Img1s上
%   Img1s，多张图像，height*weidth*dim*ImageNum,采用彩色图像
%   Img2s，多张图像，height*weidth*dim*ImageNum,采用彩色图像

if nargin < 3
   flowparam = [128, 4, 2, 10, 60, 30];
end

[height,width,dim,imageNum] = size(Img1s);
[height2,width2,dim2,imageNum2] = size(Img2s);

SIFT1All = zeros(height,width,128*imageNum,'uint8'); 
SIFT2ALL = zeros(height2,width2,128*imageNum,'uint8'); 

cellsize=3;
gridspacing=1;

for i = 1:imageNum
    im1=imresize(imfilter(Img1s(:,:,:,i),fspecial('gaussian',7,1.),'same','replicate'),1,'bicubic');
    im2=imresize(imfilter(Img2s(:,:,:,i),fspecial('gaussian',7,1.),'same','replicate'),1,'bicubic');
    
    
    siftX = mexDenseSIFT(im1,cellsize,gridspacing);
    siftY = mexDenseSIFT(im2,cellsize,gridspacing);

    SIFT1All(:,:,(i-1)*128+1:i*128) = siftX;
    SIFT2ALL(:,:,(i-1)*128+1:i*128) = siftY;
end

% sampleSIFT
samplenum = flowparam(1);

if samplenum < 128

    [~,~,dim] = size(SIFT1All);

    samplespan = dim / samplenum;

    SIFT1All = SIFT1All(:,:,1:samplespan:end);
    SIFT2ALL = SIFT2ALL(:,:,1:samplespan:end);
end

SIFTflowpara.alpha=0.25*255;
SIFTflowpara.d=40*255;
SIFTflowpara.gamma=0.005*255;%0.005*255;
SIFTflowpara.nlevels=flowparam(2);
SIFTflowpara.wsize=5; %flowparam(3);
SIFTflowpara.topwsize = 10; %flowparam(4);
SIFTflowpara.nTopIterations = flowparam(5);
SIFTflowpara.nIterations= flowparam(6);

% SIFTflowpara.alpha=2*255;
% SIFTflowpara.d=40*255;
% SIFTflowpara.gamma=0.005*255;
% SIFTflowpara.nlevels=4;
% SIFTflowpara.wsize=2;
% SIFTflowpara.topwsize=10;
% SIFTflowpara.nTopIterations = 60;
% SIFTflowpara.nIterations= 30;

[vx,vy,energylist]=SIFTflowc2f(SIFT1All,SIFT2ALL,SIFTflowpara);

uv(:,:,1)=vx;
uv(:,:,2)=vy;

end

