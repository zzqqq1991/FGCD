threshold = 0.5;

dir = 'E:\projects\cvpr2019\rebuttal\data\fig_fgcd\�ػ�����\����Ԫ������ַ\cut'; %�洢Ŀ¼
% savepath  'E:\work\our project\intrinsic&lowrank&etc\finechangedetection\level3\fineChangeDetection20160118\data\ma\image\';%����Ŀ¼

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
