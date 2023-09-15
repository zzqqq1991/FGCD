addpath('evaluation');

ratio = 10; %表示label-0 与 label-1的训练集的比例
neighbor = 5; % 表示特征维度为neighbor*neighbor

rootDir = 'E:\fineChangeDetectionData\PaperData\OurLabData\';
dir = [rootDir 'Elephant-1-2\'];

LabelName = ['OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '.bmp'];
GTName = 'GT.bmp';

label = im2double(imread([dir LabelName])) > 0.1;
GT = im2double(imread([dir GTName])) > 0.1;

eval = getAllEval(label,GT);

save([dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '_eval.mat'],'eval');
