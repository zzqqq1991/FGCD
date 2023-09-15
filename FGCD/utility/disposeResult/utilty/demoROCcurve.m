
addpath('evaluation');

ratio = 10; %表示label-0 与 label-1的训练集的比例
neighbor = 7; % 表示特征维度为neighbor*neighbor

rootDir = 'E:\fineChangeDetectionData\PaperData\酥碱\';
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