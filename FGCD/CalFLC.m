function [ flowed, lighted, change ] = CalFLC( X, Y, mask )
%CALFLC 此处显示有关此函数的摘要
%   此处显示详细说明

X = im2double(X);
Y = im2double(Y);

[imh,imw,imd] = size(X);

[ parameterflow, parameterlight, parameterdetection ] = getAllParameter();  % 想修改算法参数进 getAllParameter 里面修改
% 加上mask
if size(mask, 1) == 0
    mask = ones(imh, imw);
    mask = all(mask>0,3);
    parameterflow.mask = mask;
    parameterlight.mask = mask;
    parameterdetection.mask = mask;
end

% 计算本层
rate = 1;
tempX = resizeData(X, floor(imh*rate), floor(imw*rate));
tempY = resizeData(Y, floor(imh*rate), floor(imw*rate));
result  = FlowLightingDetection( tempX, tempY, parameterflow, parameterlight, parameterdetection );

flowed = result.Xflowed;
lighted = result.Xlighted;

change = abs(lighted - Y);



end

