tic;
im1path = '1.bmp';
im2path = '2.bmp';
im1 = imread(im1path);
im2 = imread(im2path);

im1_im2double = im2double(im1);
im2_im2double = im2double(im2);

% im1_im2double = im1_im2double(:,:,1);
% im2_im2double = im2_im2double(:,:,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 参数不写按默认
parameter = [];
parameter.interNum = 5; % 内部迭代次数
% parameter.lambda = 0.1; %%该参数越大，变化越明显，但整体越差

% parameter.fai_E = 150;  %该参数越大，变化越明显，但整体越差。 参数值可以和图像对角线长度挂钩

% parameter.lastE  %上次得到的E，为数据项提供开关. h*w*d
% parameter.mask %h*w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[im3, T] = lightingCorrection(im1_im2double,im2_im2double,parameter);

toc