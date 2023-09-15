function [ bigIm3, bigFlow ] = cameraGeometryCorrection_Piecemeal_Parallel( X,Y,parameter )
%CAMERAGEOMETRYCORRECTION_PIECEMEAL 此处显示有关此函数的摘要
%   此处显示详细说明
if nargin<3
    parameter = [];
end
if ~isfield(parameter, 'pieceWidth')
    parameter.pieceWidth = 300;
end
if ~isfield(parameter, 'pieceHeight')
    parameter.pieceHeight = 200;
end
if ~isfield(parameter, 'crossrate')
    parameter.crossrate = 0.2;
end
if ~isfield(parameter, 'marginrate')
    parameter.marginrate = 0.2;
end

[h,w,d] = size(X(:,:,:,1));
subwidth = parameter.pieceWidth;
subheight = parameter.pieceHeight;
crossrate = parameter.crossrate;
marginrate = parameter.marginrate;
%% 计算需多少行多少列的子图
shareheight = floor(subheight*(1-crossrate));
sharewidth = floor(subwidth*(1-crossrate));
marginwidth = floor(subwidth*marginrate);
marginheight = floor(subheight*marginrate);
row = floor((h-subheight+shareheight)/(shareheight));
if row < (h-subheight+shareheight)/(shareheight)
    row = row + 1;
end
column = floor((w-subwidth+sharewidth)/(sharewidth));
if column < (w-subwidth+sharewidth)/(sharewidth)
    column = column + 1;
end

bigIm3 = zeros(size(X));
bigFlow = zeros(size(X,1),size(X,2), 2);


%% 开始
parfor k = 1:row*column
    % i，j为子区域的索引，找到i和j的值
    i = rem(k-1,row)+1;
    
    j = floor((k-1)/row) + 1;
    marginX1 = 0; marginY1 = 0; marginX2 = 0; marginY2 = 0;
    usefulX1 = 0; usefulY1 = 0; usefulX2 = 0; usefulY2 = 0;


    usefulY1 = (i-1)*shareheight+1;
    usefulX1 = (j-1)*sharewidth +1;
    usefulY2 = usefulY1 + subheight-1;
    if usefulY2 > h
        usefulY2 = h;
        usefulY1 = usefulY2 - subheight + 1;
        if usefulY1 < 1
            usefulY1 = 1;
        end
    end
    usefulX2 = usefulX1 + subwidth-1;
    if usefulX2 > w
        usefulX2 = w;
        usefulX1 = usefulX2 - subwidth + 1;
        if usefulX1 < 1
            usefulX1 = 1;
        end
    end

    marginX1 = usefulX1 - marginwidth;
    marginX2 = usefulX2 + marginwidth;
    marginY1 = usefulY1 - marginheight;
    marginY2 = usefulY2 + marginheight;

    if marginX1 < 1
        marginX1 = 1;
    end
    if marginX2 > w
        marginX2 = w;
    end
    if marginY1 < 1
        marginY1 = 1;
    end
    if marginY2 > h
        marginY2 = h;
    end

    subim1 = X(marginY1:marginY2, marginX1:marginX2, :, :);
    subim2 = Y(marginY1:marginY2, marginX1:marginX2, :, :);

    [im3, flow] = cameraGeometryCorrection(subim1,subim2);

    usfulim3 = im3(usefulY1-marginY1+1 : usefulY1-marginY1+1+usefulY2-usefulY1, ...
                usefulX1-marginX1+1 : usefulX1-marginX1+1+usefulX2-usefulX1, :, :);
    usefulflow = flow(usefulY1-marginY1+1 : usefulY1-marginY1+1+usefulY2-usefulY1, ...
                usefulX1-marginX1+1 : usefulX1-marginX1+1+usefulX2-usefulX1, :, :);

    flowedIms{k} = usfulim3;
    flowMatrixs{k} = usefulflow; 

%     bigIm3(usefulY1:usefulY2, usefulX1:usefulX2, :, :) = usfulim3;
%     bigFlow(usefulY1:usefulY2, usefulX1:usefulX2, :, :) = usefulflow;        



%     rate = floor(((i-1)*column + j)/(row*column) * 100);
%     disp(['geometry correction has finished ' int2str(rate) '%']);
    disp(['geometry correction has finished part' int2str(k) ' of ' int2str(row*column)]);
end

% 合并子图
for k = 1:row*column
    % i，j为子区域的索引，找到i和j的值
    i = rem(k-1,row)+1;
    j = floor((k-1)/row) + 1;
    marginX1 = 0; marginY1 = 0; marginX2 = 0; marginY2 = 0;
    usefulX1 = 0; usefulY1 = 0; usefulX2 = 0; usefulY2 = 0;


    usefulY1 = (i-1)*shareheight+1;
    usefulX1 = (j-1)*sharewidth +1;
    usefulY2 = usefulY1 + subheight-1;
    if usefulY2 > h
        usefulY2 = h;
        usefulY1 = usefulY2 - subheight + 1;
        if usefulY1 < 1
            usefulY1 = 1;
        end
    end
    usefulX2 = usefulX1 + subwidth-1;
    if usefulX2 > w
        usefulX2 = w;
        usefulX1 = usefulX2 - subwidth + 1;
        if usefulX1 < 1
            usefulX1 = 1;
        end
    end
    
    bigIm3(usefulY1:usefulY2, usefulX1:usefulX2, :, :) = flowedIms{k};
    bigFlow(usefulY1:usefulY2, usefulX1:usefulX2, :, :) = flowMatrixs{k};
    
end


end

