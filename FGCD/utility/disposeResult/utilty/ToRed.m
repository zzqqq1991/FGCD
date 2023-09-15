ratio = 10; %表示label-0 与 label-1的训练集的比例
neighbor = 7; % 表示特征维度为neighbor*neighbor

baseDir = 'E:\fineChangeDetectionData\PaperData\酥碱\';
subDir = '9-1-small-2-3';

dir = [baseDir subDir '\'];
name = '2-1';
ext = '.bmp';
labelImage = im2double(imread([dir name ext]));
GT = im2double(imread([dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) ext]));

redImage = RedChange(labelImage,GT);
imwrite(redImage,[dir 'OCAll_Label_N' int2str(neighbor) '_Ratio' int2str(ratio) '_red' ext]);
imshow(redImage);