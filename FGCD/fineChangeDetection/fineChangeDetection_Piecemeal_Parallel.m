function [bigXError,bigYError,bigXA,bigYA] = fineChangeDetection_Piecemeal_Parallel( X,Y, parameter)
%LIGHTINGCORRECTION_BIGPICTURE 此处显示有关此函数的摘要
% separate = 1;%计算lrr时每对图像单独算
% functionnum = 2;%计算lrr中线性方程组用的方法，1：反除。2：cgs。3：symmlq。4：lsqr。5：rref
% lambda = 0.0015*paramrate;  %data项的系数 big:0.0015,middle:0.003,mini:0.006;
% gama = 0.0025*paramrate; %WE项的系数 big:0.0025,middle:0.005,mini:0.01;
% rou = paramerate;%强制项系数
% givenEX givenEY; 强制项的data
% mask; 就是mask，单通道logical的
% display = true; 显示中间结果

% paramrate 求解。参数与图像对角线长度挂钩
% [h,w,dim] = size(im);
% diagonal = (h^2+w^2)^0.5;
% paramrate = ((772^2+515^2)^0.5)/diagonal;

% parameter.pieceWidth = 400;
% parameter.pieceHeight = 300; 
% parameter.crossrate = 0.2;
%%%%%%%%%%%%%%%%%%%%
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
if ~isfield(parameter, 'mask')
    parameter.mask = ones(size(X,1), size(X, 2));
    parameter.mask = all(parameter.mask>0,3);
end
%%%%%%%%%%%%%%%%%%

mask = parameter.mask;

[h,w,d] = size(X(:,:,:,1));



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

bigXError = zeros(size(X));
bigYError = zeros(size(Y));
bigXA = zeros(size(X));
bigYA = zeros(size(Y));

% lowrankXAs = cell(1,row*column);
% lowrankXEs = cell(1,row*column);
% lowrankYAs = cell(1,row*column);
% lowrankYEs = cell(1,row*column);

subXset = cell(1, row*column);
subYset = cell(1, row*column);
lastEset = cell(1, row*column);
maskset = cell(1, row*column);
for k = 1:row*column
    % i，j为子区域的索引，找到i和j的值
    i = rem(k-1,row)+1;
    
    j = floor((k-1)/row) + 1;
    starth = (i-1)*shareheight+1;
    startw = (j-1)*sharewidth +1;
    endh = starth + subheight-1;
    if endh > h
%             starth = h - subheight + 1;
        endh = h;
        starth = endh - subheight + 1;
        if starth < 1
            starth = 1;
        end
    end
    endw = startw + subwidth-1;
    if endw > w
%             startw = w - subwidth + 1;
        endw = w;
        startw = endw - subwidth + 1;
        if startw < 1
            startw = 1;
        end
    end
    subXset{k} = X(starth:endh, startw:endw, :, :);
    subYset{k} = Y(starth:endh, startw:endw, :, :);
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
% %             starth = h - subheight + 1;
%         endh = h;
%         starth = endh - subheight + 1;
%     end
%     endw = startw + subwidth-1;
%     if endw > w
% %             startw = w - subwidth + 1;
%         endw = w;
%         startw = endw - subwidth + 1;
%     end
    subim1 = subXset{k};
    subim2 = subYset{k};
    parametertemp = parameter;
%     parametertemp.pieceWidth = parameter.pieceWidth;
%     parametertemp.pieceHeight = parameter.pieceHeight;
%     parametertemp.crossrate = parameter.crossrate;
    
    parametertemp.mask = maskset{k};

    parametertemp.givenEX = -100*ones(size(subim1));
    parametertemp.givenEY = -100*ones(size(subim1));
    if i ~= 1
        tempheight = subheight-shareheight;
        if tempheight > size(subim1,1)
            tempheight = size(subim1,1);
        end
        if isfield(parameter, 'lastEX')
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
            sublastEX = parameter.lastEX(tempstarth:tempendh, tempstartw:tempendw, :);
            sublastEY = parameter.lastEY(tempstarth:tempendh, tempstartw:tempendw, :);

            parametertemp.givenEX(1:1+tempheight-1, :, :) = sublastEX(end-tempheight+1:end, :, :);
            parametertemp.givenEY(1:1+tempheight-1, :, :) = sublastEY(end-tempheight+1:end, :, :);
        end
%         parametertemp.GivenEX(1:1+tempheight-1, :, :,:) = lowrankXEs{i-1,j}(end-tempheight+1:end, :, :,:);
%         parametertemp.GivenEY(1:1+tempheight-1, :, :,:) = lowrankYEs{i-1,j}(end-tempheight+1:end, :, :,:);
    end
    if j ~= 1
        tempwidth = subwidth-sharewidth;
        if tempwidth > size(subim1,2)
            tempwidth = size(subim1,2);
        end
        if isfield(parameter, 'lastEX')
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
            sublastEX = parameter.lastEX(tempstarth:tempendh, tempstartw:tempendw, :);
            sublastEY = parameter.lastEY(tempstarth:tempendh, tempstartw:tempendw, :);

            parametertemp.givenEX(:,1:1+tempwidth-1, :,:) = sublastEX(:,end-tempwidth+1:end, :,:);
            parametertemp.givenEY(:,1:1+tempwidth-1, :,:) = sublastEY(:,end-tempwidth+1:end, :,:);
        end
%         parametertemp.GivenEX(:,1:1+tempwidth-1, :,:) = lowrankXEs{i,j-1}(:,end-tempwidth+1:end, :,:);
%         parametertemp.GivenEY(:,1:1+tempwidth-1, :,:) = lowrankYEs{i,j-1}(:,end-tempwidth+1:end, :,:);
    end

    [XError,YError,XA,YA] = fineChangeDetection(subim1,subim2,parametertemp);
    lowrankXAs{k} = XA;
    lowrankXEs{k} = XError;
    lowrankYAs{k} = YA;
    lowrankYEs{k} = YError;

%     bigXError(starth:endh, startw:endw, :, :) = XError;
%     bigXA(starth:endh, startw:endw, :, :) = XA;
%     bigYError(starth:endh, startw:endw, :, :) = YError;
%     bigYA(starth:endh, startw:endw, :, :) = YA;

%     rate = floor(((i-1)*column + j)/(row*column) * 100);
%     disp(['fine change detection has finished ' int2str(rate) '%']);
    disp(['fine change detection has finished part' int2str(k) ' of ' int2str(row*column)]);

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
    
    bigXError(starth:endh, startw:endw, :, :) = lowrankXEs{k};
    bigXA(starth:endh, startw:endw, :, :) = lowrankXAs{k};
    bigYError(starth:endh, startw:endw, :, :) = lowrankYEs{k};
    bigYA(starth:endh, startw:endw, :, :) = lowrankYAs{k};
    
end


end

