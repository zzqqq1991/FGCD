tic;
im1path = '1.bmp';
im2path = '2.bmp';
im1 = imread(im1path);
im2 = imread(im2path);

im1_im2double = im2double(im1);
im2_im2double = im2double(im2);

% im1_im2double = im1_im2double(:,:,1);
% im2_im2double = im2_im2double(:,:,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ������д��Ĭ��
parameter = [];
parameter.interNum = 5; % �ڲ���������
% parameter.lambda = 0.1; %%�ò���Խ�󣬱仯Խ���ԣ�������Խ��

% parameter.fai_E = 150;  %�ò���Խ�󣬱仯Խ���ԣ�������Խ� ����ֵ���Ժ�ͼ��Խ��߳��ȹҹ�

% parameter.lastE  %�ϴεõ���E��Ϊ�������ṩ����. h*w*d
% parameter.mask %h*w
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[im3, T] = lightingCorrection(im1_im2double,im2_im2double,parameter);

toc