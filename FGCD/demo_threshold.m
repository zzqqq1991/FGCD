threshold = 0.5;

dir = 'E:\projects\cvpr2019\rebuttal\data\fig_fgcd\敦煌室外\监测点元代土遗址\cut'; %存储目录
% savepath  'E:\work\our project\intrinsic&lowrank&etc\finechangedetection\level3\fineChangeDetection20160118\data\ma\image\';%数据目录

ref = imread([dir '\ref.png']);
ref = im2double(ref);
facr = imread([dir '\Xlighted-1.bmp']);
facr = im2double(facr);

ref = imresize(ref, [size(facr,1), size(facr,2)]);

err = abs(ref - facr);

err = rgb2gray(err);

err = err./max(err(:));

mask = all(err > 0.2, 3);

imshow(mask);
