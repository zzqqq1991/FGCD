
% monitornames = {'�����','����','����','��������','��','ʨ��','��������'};
monitornames = {'���','����','����','���߶��ϱ�','����������'};
% monitornames = {'����1','����2','����3','����4','����5','����6','����7'};

refindex = 1;
curindex = 2;

for i = 1:5

%��ȡ����
% im1names = {'1-1','1-2','1-3','1-4','1-5','1-6','1-7'};
% im2names = {'2-1','2-2','2-3','2-4','2-5','2-6','1-7'};
% im1names = {['1-' int2str(i)]};
% im2names = {['2-' int2str(i)]};

subsize = 1/6;

pyramidrate = {1};%������������ÿ�����

predir = ['..\PAMI2017 data\Ds\' monitornames{i} '\'];
% predir = ['..\PAMI2017 data\Dl\�ּ�' int2str(i) '\'];
savepath = [predir 'result_' int2str(subsize) '_' int2str(curindex) '-' int2str(refindex) '\']; %�洢Ŀ¼
dir1 = [predir int2str(curindex) '\'];%����Ŀ¼
dir2 = [predir int2str(refindex) '\'];%����Ŀ¼
maskpath = [predir 'mask_' int2str(refindex) '.bmp']; % û��mask ��� ''

% im1names = {'image2'};
% im2names = {'image2'};
im1names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};
im2names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};

image1type = 'jpg';
image2type = 'jpg';


demo_Func(savepath, dir1, dir2, image1type, image2type, maskpath, subsize, pyramidrate, im1names, im2names);

end



refindex = 1;
curindex = 3;

for i = 1:5

%��ȡ����
% im1names = {'1-1','1-2','1-3','1-4','1-5','1-6','1-7'};
% im2names = {'2-1','2-2','2-3','2-4','2-5','2-6','1-7'};
% im1names = {['1-' int2str(i)]};
% im2names = {['2-' int2str(i)]};

subsize = 1/6;

pyramidrate = {1};%������������ÿ�����

predir = ['..\PAMI2017 data\Ds\' monitornames{i} '\'];
% predir = ['..\PAMI2017 data\Dl\�ּ�' int2str(i) '\'];
savepath = [predir 'result_' int2str(subsize) '_' int2str(curindex) '-' int2str(refindex) '\']; %�洢Ŀ¼
dir1 = [predir int2str(curindex) '\'];%����Ŀ¼
dir2 = [predir int2str(refindex) '\'];%����Ŀ¼
maskpath = [predir 'mask_' int2str(refindex) '.bmp']; % û��mask ��� ''

% im1names = {'image2'};
% im2names = {'image2'};
im1names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};
im2names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};

image1type = 'bmp';
image2type = 'bmp';


demo_Func(savepath, dir1, dir2, image1type, image2type, maskpath, subsize, pyramidrate, im1names, im2names);

end