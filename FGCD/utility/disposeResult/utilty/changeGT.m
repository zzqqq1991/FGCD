
baseDir = 'E:\fineChangeDetectionData\trainingData\AllCleanWithResult2\';
% 调整GT的值

subDir = 'goldBuddha';

dir = [baseDir subDir '\'];
GTName = 'GT';
reName = 'OCAll_Label_N5_Ratio10_thres';
ext = '.bmp';

GT = im2double(imread([dir GTName ext]));
Re = im2double(imread([dir reName ext]));

D = Re- GT;
ad =  abs(D);
imwrite(ad,'ad.bmp');
%%%
ad = im2double(imread('ad.bmp'));
Dc = ad;
cGT = GT + D.*Dc;
imwrite(cGT, 'cGT.bmp');