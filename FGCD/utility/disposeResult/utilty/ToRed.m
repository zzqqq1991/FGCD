ratio = 10; %��ʾlabel-0 �� label-1��ѵ�����ı���
neighbor = 7; % ��ʾ����ά��Ϊneighbor*neighbor

baseDir = 'E:\fineChangeDetectionData\PaperData\�ּ�\';
subDir = '9-1-small-2-3';

dir = [baseDir subDir '\'];
name = '2-1';
ext = '.bmp';
labelImage = im2double(imread([dir name ext]));
GT = im2double(imread([dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) ext]));

redImage = RedChange(labelImage,GT);
imwrite(redImage,[dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '_red' ext]);
imshow(redImage);