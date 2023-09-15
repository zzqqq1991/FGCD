
addpath('evaluation');

ratio = 10; %��ʾlabel-0 �� label-1��ѵ�����ı���
neighbor = 7; % ��ʾ����ά��Ϊneighbor*neighbor

rootDir = 'E:\fineChangeDetectionData\PaperData\�ּ�\';
dir = [rootDir '2-3-small-2-3\'];
subDir = 

DecValName = ['OCAll_DecValue_N' int2str(neighbor) '_Ratio' int2str(ratio) '.mat'];
load(DecValName);
GTName = 'GT.bmp';

DecVal = dec_value_Img;
GT = im2double(imread([dir GTName])) > 0.1;

%usage 1:
[X,Y,T,AUC]  = PRROCPointByImage( GT,DecVal,1,0 );
h = figure;
plot(X,Y);
xlabel('False positive rate');
ylabel('True positive rate');
title('ROC Curve for classification by SVM');


save([dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '_eval.mat'],'eval');