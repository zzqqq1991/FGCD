function [ im1to2, flow1to2 ] = cameraGeometryCorrection( im1, im2, parameter )
%CAMERAGEOMETRYCORRECTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

if nargin<3
    parameter.flowparam  = [128, 4, 2, 10, 60, 30];
end

if ~exist('parameter.flowparam','var')
    parameter.flowparam  = [128, 4, 2, 10, 60, 30];
end

X = im1;
Y = im2;

flow1to2 = SIFTFlow_Multiple(Y,X,parameter.flowparam);
im1to2 = warpAllImages(Y,X,flow1to2);

end

