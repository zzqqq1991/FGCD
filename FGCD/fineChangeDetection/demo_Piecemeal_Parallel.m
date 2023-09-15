startTime = clock;

dir1 = 'D:\ZhangQian\fineChangeDetection20150109\result\Parallel\DH\25-3\';%数据目录
dir2 = 
%读取数据
im1names = {'Xlighted-1'};
im2names = {'2'};

 
% %设置参数
% [h,w,dim] = size(imread([dir im1names{1} '.bmp']));
% diagonal = (h^2+w^2)^0.5;
% paramrate = ((772^2+515^2)^0.5)/diagonal;
% separate = 1;%计算lrr时每对图像单独算
% functionnum = 2;%计算lrr中线性方程组用的方法，1：反除。2：cgs。3：symmlq。4：lsqr。5：rref
% lambda = 0.0015*paramrate;  %data项的系数 big:0.0015,middle:0.003,mini:0.006;
% gama = 0.0025*paramrate; %WE项的系数 big:0.0025,middle:0.005,mini:0.01;
% rou = 0.02*paramrate;%强制项系数
    
%parameter设置
parameter = [];
% parameter.separate = separate;
% parameter.functionnum = functionnum;
% parameter.lambda = lambda;
% parameter.gama = gama;
% parameter.display = true;
parameter.pieceWidth = 400;
parameter.pieceHeight = 300;
parameter.crossrate = 0.2;
parameter.lambda = 0.0015;  % 值约大，得到的变化越少
parameter.gama = 0.0025;
%开始
X = [];
Y = [];
for i = 1:length(im1names)
    im1 = imread([dir im1names{i} '.bmp']);
    im1 = im2double(im1);
    X(:,:,:,i) = im1;
    im2 = imread([dir im2names{i} '.bmp']);
    im2 = im2double(im2);
    Y(:,:,:,i) = im2;
end
[XError,YError,XA,YA] = fineChangeDetection_Piecemeal_Parallel(X,Y,parameter);

EX = XError(:,:,:,1);
EY = YError(:,:,:,1);
AX = XA(:,:,:,1);
AY = YA(:,:,:,1);

%计时结束，统计时间
endTime = clock;
duringTime = etime(endTime,startTime);
disp(['Total Time is: ' num2str(duringTime) ' second']); 


imwrite(EX, 'EX.bmp');
imwrite(EY, 'EY.bmp');
imwrite(AX, 'AX.bmp');
imwrite(AY, 'AY.bmp');