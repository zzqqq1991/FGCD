function [ biglightingIm, bigT ] = lightingCorrection_Piecemeal_Parallel( im1,im2, parameter)
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

im1org = im1;
im2org = im2;

[orgh,orgw,~] = size(im1org);

ratio = 0.25;
im1 = imresize(im1, ratio);
im2 = imresize(im2, ratio);

if nargin<3
    parameter = [];
end

if ~isfield(parameter, 'pieceWidth')
    parameter.pieceWidth = 400;
end
if ~isfield(parameter, 'pieceHeight')
    parameter.pieceHeight = 300;
end
if ~isfield(parameter, 'crossrate')
    parameter.crossrate = 0.2;
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

% lightingCorrectIms = cell(1, row*column);
% lightingTs = cell(1, row*column);

subim1set = cell(1, row*column);
subim2set = cell(1, row*column);
lastEset = cell(1, row*column);
maskset = cell(1, row*column);
parfor k = 1:row*column
    i = rem(k-1,row)+1;
    
    j = floor((k-1)/row) + 1;
    starth = (i-1)*shareheight+1;
    startw = (j-1)*sharewidth +1;
    endh = starth + subheight-1; 
    if endh > h
        endh = h;
        starth = endh - subheight + 1;
        if starth < 1
            starth = 1;
        end
    end
    endw = startw + subwidth-1;
    if endw > w
        endw = w;
        startw = endw - subwidth + 1;
        if startw < 1
            startw = 1;
        end
    end
    subim1set{k} = im1(starth:endh, startw:endw, :);
    subim2set{k} = im2(starth:endh, startw:endw, :);
    lastEset{k} = lastE(starth:endh, startw:endw, :);
    maskset{k} = mask(starth:endh, startw:endw, :);
end

parfor k = 1:row*column
    % i，j为子区域的索引，找到i和j的值
    i = rem(k-1,row)+1;
    
    j = floor((k-1)/row) + 1;
%     starth = (i-1)*shareheight+1;
%     startw = (j-1)*sharewidth +1;
%     endh = starth + subheight-1; 
%     if endh > h
%         endh = h;
%         starth = endh - subheight + 1;
%     end
%     endw = startw + subwidth-1;
%     if endw > w
%         endw = w;
%         startw = endw - subwidth + 1;
%     end
    subim1 = subim1set{k};
    subim2 = subim2set{k};
    
    % 设置parametertemp
    parametertemp = parameter;

    parametertemp.lastE = lastEset{k};
    parametertemp.mask = maskset{k};
    parametertemp.GivenT = -100*ones(size(subim1));
    if i ~= 1
        tempheight = subheight-shareheight;
        if tempheight > size(subim1,1)
            tempheight = size(subim1,1);
        end
        
        if isfield(parameter, 'lastT')
            tempstarth = (i-1-1)*shareheight+1;
            tempstartw = (j-1)*sharewidth +1;
            tempendh = tempstarth + subheight-1; 
            if tempendh > h
                tempendh = h;
                tempstarth = tempendh - subheight + 1;
            end
            tempendw = tempstartw + subwidth-1;
            if tempendw > w
                tempendw = w;
                tempstartw = tempendw - subwidth + 1;
            end
            sublastT = parameter.lastT(tempstarth:tempendh, tempstartw:tempendw, :);

            parametertemp.GivenT(1:1+tempheight-1, :, :) = sublastT(end-tempheight+1:end, :, :);
        end
%             parametertemp.GivenT(1:1+tempheight-1, :, :) = lightingTs{i-1,j}(end-tempheight+1:end, :, :);
    end
    if j ~= 1
        tempwidth = subwidth-sharewidth;
        if tempwidth > size(subim1,2)
            tempwidth = size(subim1,2);
        end
        if isfield(parameter, 'lastT')
            tempstarth = (i-1)*shareheight+1;
            tempstartw = (j-1-1)*sharewidth +1;
            tempendh = tempstarth + subheight-1; 
            if tempendh > h
                tempendh = h;
                tempstarth = tempendh - subheight + 1;
            end
            tempendw = tempstartw + subwidth-1;
            if tempendw > w
                tempendw = w;
                tempstartw = tempendw - subwidth + 1;
            end
            sublastT = parameter.lastT(tempstarth:tempendh, tempstartw:tempendw, :);

            parametertemp.GivenT(:,1:1+tempwidth-1, :) = sublastT(:,end-tempwidth+1:end, :);
        end
%             parametertemp.GivenT(:,1:1+tempwidth-1, :) = lightingTs{i,j-1}(:,end-tempwidth+1:end, :);
    end
    
    %计算并记录结果
    [im3, T] = lightingCorrection(subim1,subim2,parametertemp);
%     lightingCorrectIms{k} = im3;
    lightingTs{k} = T;

%         biglightingIm(starth:endh, startw:endw, :) = im3;
%         bigT(starth:endh, startw:endw, :) = T;

    %输出进度
%     rate = floor(k/(row*column) * 100);
%     disp(['lighting correction has finished ' int2str(rate) '%']);

    disp(['lighting correction has finished part' int2str(k) ' of ' int2str(row*column)]);
end

% 合并子图
for k = 1:row*column
    % i，j为子区域的索引，找到i和j的值
    i = rem(k-1,row)+1;
    j = floor((k-1)/row) + 1;
    starth = (i-1)*shareheight+1;
    startw = (j-1)*sharewidth +1;
    endh = starth + subheight-1; 
    if endh > h
        endh = h;
        starth = endh - subheight + 1;
        if starth < 1
            starth = 1;
        end
    end
    endw = startw + subwidth-1;
    if endw > w
        endw = w;
        startw = endw - subwidth + 1;
        if startw < 1
            startw = 1;
        end
    end
    
%     biglightingIm(starth:endh, startw:endw, :) = lightingCorrectIms{k};
    bigT(starth:endh, startw:endw, :) = lightingTs{k};
    
end


bigT = imresize(bigT, [orgh, orgw]);

biglightingIm = bigT + im1org;


end

