
% monitornames = {'半蹲像','大象','观音','伸手立像','马','狮子','握手立像'};
monitornames = {'金佛','两佛','西壁','洞窟东南壁','洞窟南西壁'};
% monitornames = {'疱疹1','疱疹2','疱疹3','疱疹4','疱疹5','疱疹6','疱疹7'};

refindex = 1;
curindex = 2;

for i = 1:5

%读取数据
% im1names = {'1-1','1-2','1-3','1-4','1-5','1-6','1-7'};
% im2names = {'2-1','2-2','2-3','2-4','2-5','2-6','1-7'};
% im1names = {['1-' int2str(i)]};
% im2names = {['2-' int2str(i)]};

subsize = 1/6;

pyramidrate = {1};%金字塔层数及每层比例

predir = ['..\PAMI2017 data\Ds\' monitornames{i} '\'];
% predir = ['..\PAMI2017 data\Dl\酥碱' int2str(i) '\'];
savepath = [predir 'result_' int2str(subsize) '_' int2str(curindex) '-' int2str(refindex) '\']; %存储目录
dir1 = [predir int2str(curindex) '\'];%数据目录
dir2 = [predir int2str(refindex) '\'];%数据目录
maskpath = [predir 'mask_' int2str(refindex) '.bmp']; % 没有mask 设成 ''

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

%读取数据
% im1names = {'1-1','1-2','1-3','1-4','1-5','1-6','1-7'};
% im2names = {'2-1','2-2','2-3','2-4','2-5','2-6','1-7'};
% im1names = {['1-' int2str(i)]};
% im2names = {['2-' int2str(i)]};

subsize = 1/6;

pyramidrate = {1};%金字塔层数及每层比例

predir = ['..\PAMI2017 data\Ds\' monitornames{i} '\'];
% predir = ['..\PAMI2017 data\Dl\酥碱' int2str(i) '\'];
savepath = [predir 'result_' int2str(subsize) '_' int2str(curindex) '-' int2str(refindex) '\']; %存储目录
dir1 = [predir int2str(curindex) '\'];%数据目录
dir2 = [predir int2str(refindex) '\'];%数据目录
maskpath = [predir 'mask_' int2str(refindex) '.bmp']; % 没有mask 设成 ''

% im1names = {'image2'};
% im2names = {'image2'};
im1names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};
im2names = {'image1','image2','image3','image4','image5','image6','image7','image8','image9','image10','image11','image12','image13'};

image1type = 'bmp';
image2type = 'bmp';


demo_Func(savepath, dir1, dir2, image1type, image2type, maskpath, subsize, pyramidrate, im1names, im2names);

end