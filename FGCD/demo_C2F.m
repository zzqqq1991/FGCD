%%
savepath = 'E:\work\intrinsic&lowrank&etc\finechangedetection\level3\fineChangeDetection20160118\result\Parallel\test\test2\'; %存储目录
dir = 'E:\work\intrinsic&lowrank&etc\finechangedetection\level3\fineChangeDetection20160118\result\Parallel\sujian\';%数据目录
pyramidrate = {0.3, 0.5, 1};%金字塔层数及每层比例
%读取数据
im1names = {'1-1'};
im2names = {'2-1'};
%%

X = [];
Y = [];
for i = 1:length(im1names)
    im1 = imread([dir im1names{i} '.bmp']);
    im1 = im2double(im1);
    im1 = imresize(im1, 1);
    X(:,:,:,i) = im1;
    im2 = imread([dir im2names{i} '.bmp']);
    im2 = im2double(im2);
    im2 = imresize(im2, 1);
    Y(:,:,:,i) = im2;
end

imh = size(X, 1);
imw = size(X, 2);

[ parameterflow, parameterlight, parameterdetection ] = getAllParameter();

tempX = resizeData(X, floor(imh*pyramidrate{1}), floor(imw*pyramidrate{1}));
tempY = resizeData(Y, floor(imh*pyramidrate{1}), floor(imw*pyramidrate{1}));

lastUV = zeros(imh, imw, 2);
for i = 1:length(pyramidrate)
    % 计算本层
%     rate = pyramidrate{i};
    result  = FlowLightingDetection( tempX, tempY, parameterflow, parameterlight, parameterdetection );
    tempsavepath = [savepath 'layer' int2str(i) '\'];
    mkdir(tempsavepath);
    saveResult(result, tempsavepath);
    save([tempsavepath 'parameter.mat'], 'parameterflow', 'parameterlight', 'parameterdetection');
    
    % 更新下层参数
    if i ~= length(pyramidrate)
        nextrate = pyramidrate{i+1};
        nexth = floor(imh*nextrate);
        nextw = floor(imw*nextrate);
        tempY = resizeData(Y, nexth, nextw);
        lastUV = resizeUVflow(lastUV, [nexth, nextw], 'bicubic');
        addedUV = resizeUVflow(result.Xflow, [nexth, nextw], 'bicubic');
        lastUV = lastUV + addedUV;
        tempX = resizeData(X, nexth, nextw);
        tempX = warpAllImages(tempY, tempX, lastUV);
        
        
    end
    


end




