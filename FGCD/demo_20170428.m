clear;
%%
presavepath = 'E:\data\���ݴ���\�ú�԰\2017\960 640\result\'; %�洢Ŀ¼
predir1 = 'E:\data\���ݴ���\�ú�԰\2017\960 640\2016���ļ���\';%����Ŀ¼
predir2 = 'E:\data\���ݴ���\�ú�԰\2017\960 640\��һ����\';%����Ŀ¼


monitorname = {'�������������','��������'};

for k = 1:2
    
savepath = [presavepath monitorname{k} '\'];
dir1 = [predir1 monitorname{k} '\'];
dir2 = [predir2 monitorname{k} '\'];

% index = 2;
maskpath = ''; % û��mask ��� ''

subsize = 1.0;
pyramidrate = {1};%������������ÿ�����
%��ȡ����
% im1names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};
% im2names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};
im1names = {'image1'};
im2names = {'image1'};
% im1names = {'1-1'};
% im2names = {'2-1'};
imagetype = 'bmp';
%%

X = [];
Y = [];
for i = 1:length(im1names)
    im1 = imread([dir1 im1names{i} '.' imagetype]);
    im1 = im2double(im1);
    im1 = imresize(im1, subsize);
    X(:,:,:,i) = im1;
    im2 = imread([dir2 im2names{i} '.' imagetype]);
    im2 = im2double(im2);
    im2 = imresize(im2, subsize);
    Y(:,:,:,i) = im2;
end

imh = size(X, 1);
imw = size(X, 2);

[ parameterflow, parameterlight, parameterdetection ] = getAllParameter();  % ���޸��㷨������ getAllParameter �����޸�
% ����mask
if size(maskpath) > 0
    mask = imread(maskpath);
    mask = imresize(mask, subsize);
    mask = all(mask>0,3);
    parameterflow.mask = mask;
    parameterlight.mask = mask;
    parameterdetection.mask = mask;
end


tempX = X;
tempY = Y;
for i = 1:length(pyramidrate)
    % ���㱾��
    rate = pyramidrate{i};
    tempX = resizeData(X, floor(imh*rate), floor(imw*rate));
    tempY = resizeData(Y, floor(imh*rate), floor(imw*rate));
    result  = FlowLightingDetection( tempX, tempY, parameterflow, parameterlight, parameterdetection );
%     tempsavepath = [savepath 'layer' int2str(i) '\'];
%     mkdir(tempsavepath);
%     saveResult(result, tempsavepath);
%     save([tempsavepath 'parameter.mat'], 'parameterflow', 'parameterlight', 'parameterdetection');
%     �����²����
%     nextrate = 1;
%     if i ~= length(pyramidrate)
%         nextrate = pyramidrate{i+1};
%     end
%     parameterlight.givenLightedT = resizeData(result.lightedT, floor(imh*nextrate), floor(imw*nextrate));
%     parameterdetection.givenEX = resizeData(result.XError, floor(imh*nextrate), floor(imw*nextrate));
%     parameterdetection.givenEY = resizeData(result.YError, floor(imh*nextrate), floor(imw*nextrate));
end

beforefile = [savepath '����ǰ'];
mkdir(beforefile);
afterfile = [savepath '�����'];
mkdir(afterfile);
imagenum = length(im1names);

for i = 1:imagenum
    im1 = imread([dir1 im1names{i} '.' imagetype]);
    imwrite(im1, [beforefile '\1-' int2str(i) '.bmp']);
    im2 = imread([dir2 im2names{i} '.' imagetype]);
    imwrite(im2, [beforefile '\2-' int2str(i) '.bmp']);
    
    imwrite(im2, [afterfile '\2-' int2str(i) '.bmp']);
    
    imwrite(result.Xlighted(:,:,:,i), [afterfile '\1-' int2str(i) '.bmp']);
end

end


