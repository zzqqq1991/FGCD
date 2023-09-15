baseDir = 'E:\fineChangeDetectionData\trainingData\AllCleanWithResult1\4-1-small-3-4\';
subDir = '';

dir = [baseDir subDir '\'];
name = 'OCAll_Label_N5_Ratio10';
ext = '.bmp';
labelImage = im2double(imread([dir name ext]));
labelImage = labelImage > 0.5;
GT = im2double(imread([dir 'GT' ext]));

fmeasure = GetEvaluationByImage(labelImage,GT,1,'fmeasure');
save([dir name '_f1.mat'],'fmeasure');