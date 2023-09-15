baseDir = 'E:\fineChangeDetectionData\trainingData\AllCleanWithResult2\';
subDir = 'goldBuddha';

dir = [baseDir subDir '\'];
name = 'OCAll_Label_N5_Ratio10';
ext = '.bmp';
labelImage = im2double(imread([dir name ext]));
label_thres = C_thres(labelImage, 0.1,3,4);
imshow(label_thres);
imwrite(label_thres,[dir name '_thres' ext]);
