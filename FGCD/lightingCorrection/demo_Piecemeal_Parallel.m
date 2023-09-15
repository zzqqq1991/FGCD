
rootdir = 'F:\syb';
for i = 1:2
    
subdir = [rootdir '\' int2str(i)];
    
im1 = imread([subdir '\warp.jpg']);
im2 = imread([subdir '\2.jpg']);


% im1 = imresize(im1, 0.5);
% im2 = imresize(im2, 0.5);

im1_im2double = im2double(im1);
im2_im2double = im2double(im2);

% im1_im2double = im1_im2double(:,:,1);
% im2_im2double = im2_im2double(:,:,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 参数不写按默认
parameter = [];
parameter.interNum = 5; % 内部迭代次数
% parameter.lambda = 0.1; %%该参数越大，变化越明显，但整体越差

% [h,w,d] = size(im1);
% diagonal = (h^2+w^2)^0.5;
% paramrate = diagonal / ((772^2+515^2)^0.5);
% parameter.fai_E = 150*paramrate;  %该参数越大，变化越明显，但整体越差。 参数值可以和图像对角线长度挂钩

% parameter.lastE  %上次得到的E，为数据项提供开关. h*w*d
% parameter.mask %h*w

parameter.pieceWidth = 500;
parameter.pieceHeight = 600;
parameter.interNum = 5; % 内部迭代次数
parameter.lambda = 50; % 越小变化越明显，但值过小会导致和参考图像完全相同
parameter.fai_E = 80;
parameter.Omega = 0;
% parameter.crossrate = 0.2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[im3, T] = lightingCorrection_Piecemeal_Parallel(im1_im2double,im2_im2double,parameter);

imwrite(im3, [subdir '\lighted.jpg']);

end