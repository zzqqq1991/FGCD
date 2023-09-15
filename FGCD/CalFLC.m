function [ flowed, lighted, change ] = CalFLC( X, Y, mask )
%CALFLC �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

X = im2double(X);
Y = im2double(Y);

[imh,imw,imd] = size(X);

[ parameterflow, parameterlight, parameterdetection ] = getAllParameter();  % ���޸��㷨������ getAllParameter �����޸�
% ����mask
if size(mask, 1) == 0
    mask = ones(imh, imw);
    mask = all(mask>0,3);
    parameterflow.mask = mask;
    parameterlight.mask = mask;
    parameterdetection.mask = mask;
end

% ���㱾��
rate = 1;
tempX = resizeData(X, floor(imh*rate), floor(imw*rate));
tempY = resizeData(Y, floor(imh*rate), floor(imw*rate));
result  = FlowLightingDetection( tempX, tempY, parameterflow, parameterlight, parameterdetection );

flowed = result.Xflowed;
lighted = result.Xlighted;

change = abs(lighted - Y);



end

