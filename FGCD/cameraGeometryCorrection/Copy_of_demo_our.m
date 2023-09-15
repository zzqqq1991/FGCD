startTime = clock;
rootdir = 'G:\颐和园\清可轩摩崖石刻2016年\颐和园2016年四季度监测数据及报告\第1季度\清可轩西壁\处理前\';
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

%计时结束，统计时间
endTime = clock;
duringTime = etime(endTime,startTime);
disp(['Total Time is: ' num2str(duringTime) ' second']); 