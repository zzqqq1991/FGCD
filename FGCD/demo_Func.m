function [  ] = demo_Func( savepath , dir1, dir2, image1type, image2type, maskpath, subsize, pyramidrate, im1names ,im2names)
%DEMO_FUNC 此处显示有关此函数的摘要
%   此处显示详细说明
%%
% savepath = 'E:\work\intrinsic&lowrank&etc\finechangedetection\level3\fineChangeDetection20160118\result\20160328\GoldBuddha\2\'; %存储目录
% dir = 'E:\work\intrinsic&lowrank&etc\finechangedetection\AllPaperSelectCleanData\SummerPalace\GoldBuddha\';%数据目录
% pyramidrate = {1};%金字塔层数及每层比例
% %读取数据
% % im1names = {'1-1','1-2','1-3','1-4','1-5','1-6','1-7'};
% % im2names = {'2-1','2-2','2-3','2-4','2-5','2-6','1-7'};
% im1names = {'1-2'};
% im2names = {'2-2'};
%%

X = [];
Y = [];
for i = 1:length(im1names)
    im1 = imread([dir1 im1names{i} '.' image1type]);
    im1 = im2double(im1);
    im1 = imresize(im1, subsize);
    X(:,:,:,i) = im1;
    im2 = imread([dir2 im2names{i} '.' image2type]);
    im2 = im2double(im2);
    im2 = imresize(im2, subsize);
    Y(:,:,:,i) = im2;
end

imh = size(X, 1);
imw = size(X, 2);

[ parameterflow, parameterlight, parameterdetection ] = getAllParameter();  % 想修改算法参数进 getAllParameter 里面修改
% 加上mask
if size(maskpath) > 0
    mask = imread(maskpath);
    mask = imresize(mask, subsize);
    mask = all(mask>0.5,3);
    parameterflow.mask = mask;
    parameterlight.mask = mask;
    parameterdetection.mask = mask;
end


tempX = X;
tempY = Y;
for i = 1:length(pyramidrate)
    % 计算本层
    rate = pyramidrate{i};
    tempX = resizeData(X, floor(imh*rate), floor(imw*rate));
    tempY = resizeData(Y, floor(imh*rate), floor(imw*rate));
    result  = FlowLightingDetection( tempX, tempY, parameterflow, parameterlight, parameterdetection );
    tempsavepath = [savepath 'layer' int2str(i) '\'];
    mkdir(tempsavepath);
    
    % 加入mask
    result.Xflowed = bsxfun(@times, result.Xflowed, mask);
    result.Xflow = bsxfun(@times, result.Xflow, mask);
    result.Xlighted = bsxfun(@times, result.Xlighted, mask);
    result.lightedT = bsxfun(@times, result.lightedT, mask);
    
    saveResult(result, tempsavepath);
    save([tempsavepath 'parameter.mat'], 'parameterflow', 'parameterlight', 'parameterdetection');
%     更新下层参数
%     nextrate = 1;
%     if i ~= length(pyramidrate)
%         nextrate = pyramidrate{i+1};
%     end
%     parameterlight.givenLightedT = resizeData(result.lightedT, floor(imh*nextrate), floor(imw*nextrate));
%     parameterdetection.givenEX = resizeData(result.XError, floor(imh*nextrate), floor(imw*nextrate));
%     parameterdetection.givenEY = resizeData(result.YError, floor(imh*nextrate), floor(imw*nextrate));
end


end

