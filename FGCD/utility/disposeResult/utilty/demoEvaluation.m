addpath('evaluation');

ratio = 10; %��ʾlabel-0 �� label-1��ѵ�����ı���
neighbor = 5; % ��ʾ����ά��Ϊneighbor*neighbor

rootDir = 'E:\fineChangeDetectionData\PaperData\OurLabData\';
dir = [rootDir 'Elephant-1-2\'];

LabelName = ['OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '.bmp'];
GTName = 'GT.bmp';

label = im2double(imread([dir LabelName])) > 0.1;
GT = im2double(imread([dir GTName])) > 0.1;

eval = getAllEval(label,GT);

save([dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '_eval.mat'],'eval');
