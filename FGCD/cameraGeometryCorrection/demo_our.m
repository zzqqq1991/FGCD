startTime = clock;

rootdir = 'E:\�����ĵ�\20191107 ����ʦϸ��ͼ';

im1 = imread([rootdir, '\im1.jpg']);
im2 = imread([rootdir, '\im2.jpg']);
im1 = im2double(im1);
im2 = im2double(im2);

im1 = imresize(im1, 1);
im2 = imresize(im2, 1);

X = [];
Y = [];
X(:,:,:,1) = im1;
Y(:,:,:,1) = im2;

[im3, flow] = cameraGeometryCorrection(X,Y);

imwrite(im3, [rootdir, '\warp.jpg']);

%��ʱ������ͳ��ʱ��
endTime = clock;
duringTime = etime(endTime,startTime);
disp(['Total Time is: ' num2str(duringTime) ' second']); 