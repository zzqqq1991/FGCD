startTime = clock;
rootdir = 'F:\syb';

for i = 1:2

    subdir = [rootdir '\' int2str(i)];
    
    im1 = imread([subdir '\1.jpg']);
    im2 = imread([subdir '\2.jpg']);
    im1 = im2double(im1);
    im2 = im2double(im2);

    im1 = imresize(im1, 1);
    im2 = imresize(im2, 1);

    X = [];
    Y = [];
    X(:,:,:,1) = im1;
    Y(:,:,:,1) = im2;

    parameter = [];
    parameter.pieceWidth = 500;
    parameter.pieceHeight = 600;
    [im3, flow] = cameraGeometryCorrection_Piecemeal_Parallel(X,Y, parameter);

    imwrite(im3, [subdir '\warp.jpg']);

    %计时结束，统计时间
    endTime = clock;
    duringTime = etime(endTime,startTime);
    disp(['Total Time is: ' num2str(duringTime) ' second']); 

end