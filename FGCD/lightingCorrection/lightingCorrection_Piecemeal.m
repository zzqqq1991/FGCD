function [ biglightingIm, bigT ] = lightingCorrection_Piecemeal( im1,im2, parameter)
%LIGHTINGCORRECTION_BIGPICTURE 此处显示有关此函数的摘要
% parameter.lambda; %%该参数越大，变化越明显，但整体越差。默认0.1
% parameter.updateColorDiffItemWeight = 'lastE'; %lastE,null， lastE
% parameter.fai_E;  %该参数越大，变化越明显，但整体越差。 参数值与图像对角线长度相关
% parameter.lastE  %上次得到的E，为数据项提供开关
% parameter.Omega %强制相同的项的权重。默认1
% parameter.GivenT %强制项数据
% parameter.interNum; 内部迭代次数，默认1
% parameter.mask

% parameter.pieceWidth = 400;
% parameter.pieceHeight = 300;
% parameter.crossrate = 0.2;
%%%%%%%%%%%%%%%%%%%%
if nargin<3
    parameter = [];
end

if ~isfield(parameter, 'pieceWidth')
    parameter.pieceWidth = 900;
end
if ~isfield(parameter, 'pieceHeight')
    parameter.pieceHeight = 700;
end
if ~isfield(parameter, 'crossrate')
    parameter.crossrate = 0.1;
end
if ~isfield(parameter, 'lastE')
    parameter.lastE = zeros(size(im2));
end
if ~isfield(parameter, 'mask')
    parameter.mask = ones(size(im1,1), size(im1, 2));
    parameter.mask = all(parameter.mask>0,3);
end
%%%%%%%%%%%%%%%%%%

mask = parameter.mask;
lastE = parameter.lastE;

[h,w,d] = size(im1);

lightingCorrectIms = {};
lightingTs = {};

subwidth = parameter.pieceWidth;
subheight = parameter.pieceHeight;
crossrate = parameter.crossrate;
shareheight = floor(subheight*(1-crossrate));
sharewidth = floor(subwidth*(1-crossrate));
row = floor((h-subheight+shareheight)/(shareheight));
if row < (h-subheight+shareheight)/(shareheight)
    row = row + 1;
end
column = floor((w-subwidth+sharewidth)/(sharewidth));
if column < (w-subwidth+sharewidth)/(sharewidth)
    column = column + 1;
end
biglightingIm = zeros(size(im1));
bigT = zeros(size(im1));
for i = 1:row
    for j = 1:column
        starth = (i-1)*shareheight+1;
        startw = (j-1)*sharewidth +1;
        endh = starth + subheight-1;
        if endh > h
%             starth = h - subheight + 1;
            endh = h;
        end
        endw = startw + subwidth-1;
        if endw > w
%             startw = w - subwidth + 1;
            endw = w;
        end
        subim1 = im1(starth:endh, startw:endw, :);
        subim2 = im2(starth:endh, startw:endw, :);
        
        parameter.lastE = lastE(starth:endh, startw:endw, :);
        parameter.mask = mask(starth:endh, startw:endw, :);
        parameter.GivenT = -100*ones(size(subim1));
        if i ~= 1
            tempheight = subheight-shareheight;
            if tempheight > size(subim1,1)
                tempheight = size(subim1,1);
            end
            parameter.GivenT(1:1+tempheight-1, :, :) = lightingTs{i-1,j}(end-tempheight+1:end, :, :);
        end
        if j ~= 1
            tempwidth = subwidth-sharewidth;
            if tempwidth > size(subim1,2)
                tempwidth = size(subim1,2);
            end
            parameter.GivenT(:,1:1+tempwidth-1, :) = lightingTs{i,j-1}(:,end-tempwidth+1:end, :);
        end
        [im3, T] = lightingCorrection(subim1,subim2,parameter);
        lightingCorrectIms{i,j} = im3;
        lightingTs{i,j} = T;
        
        biglightingIm(starth:endh, startw:endw, :) = im3;
        bigT(starth:endh, startw:endw, :) = T;
        
        
        rate = floor(((i-1)*column + j)/(row*column) * 100);
        disp(['lighting correction has finished ' int2str(rate) '%']);
    end
end


end

