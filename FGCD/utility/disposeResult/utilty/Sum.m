

baseDir = 'E:\fineChangeDetectionData\trainingData\AllCleanWithResult2\';
subDir = 'goldBuddha';

dir = [baseDir subDir '\'];
GTName = 'GT';
reName = 'OCAll_Label_N5_Ratio10_thres';
ext = '.bmp';

GT = im2double(imread([dir GTName ext]));
Re = im2double(imread([dir reName ext]));

sum = (GT + Re) > 0;
imwrite(sum,[dir 'GTsum' ext]);