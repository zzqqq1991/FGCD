tic;

im1path = ['C:\Users\lenovo\Desktop\IJCAI PPT\realword\1\side\ref.png'];
im2path = ['C:\Users\lenovo\Desktop\IJCAI PPT\realword\1\side\alr.png'];
im1 = imread(im1path);
im2 = imread(im2path);

im1 = imresize(im1, 0.5);
im2 = imresize(im2, 0.5);

im1_im2double = im2double(im1);
im2_im2double = im2double(im2);

% im1_im2double = im1_im2double(:,:,1);
% im2_im2double = im2_im2double(:,:,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ������д��Ĭ��
parameter = [];
parameter.interNum = 5; % �ڲ���������
parameter.lambda = 0.1; %%�ò���Խ�󣬱仯Խ���ԣ�������Խ��

% [h,w,d] = size(im1);
% diagonal = (h^2+w^2)^0.5;
% paramrate = diagonal / ((772^2+515^2)^0.5);
% parameter.fai_E = 150*paramrate;  %�ò���Խ�󣬱仯Խ���ԣ�������Խ� ����ֵ���Ժ�ͼ��Խ��߳��ȹҹ�

% parameter.lastE  %�ϴεõ���E��Ϊ�������ṩ����. h*w*d
% parameter.mask %h*w

% parameter.pieceWidth = 400;
% parameter.pieceHeight = 300;
% parameter.crossrate = 0.2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[im3, T] = lightingCorrection_Piecemeal(im1_im2double,im2_im2double,parameter);

imwrite(im3, 'C:\Users\lenovo\Desktop\IJCAI PPT\realword\1\side\result.png');

toc