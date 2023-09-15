startTime = clock;
rootdir = 'G:\�ú�԰\�����Ħ��ʯ��2016��\�ú�԰2016���ļ��ȼ�����ݼ�����\��1����\���������\����ǰ\';
im1=imread([rootdir '2-1.bmp']);
im2=imread([rootdir '1-1.bmp']);
im1 = im2double(im1);
im2 = im2double(im2);

im1 = imresize(im1, 1);
im2 = imresize(im2, 1);

X = [];
Y = [];
X(:,:,:,1) = im1;
Y(:,:,:,1) = im2;

[im3, flow] = cameraGeometryCorrection(X,Y);

imwrite(im3, 'result.bmp');

%��ʱ������ͳ��ʱ��
endTime = clock;
duringTime = etime(endTime,startTime);
disp(['Total Time is: ' num2str(duringTime) ' second']); 