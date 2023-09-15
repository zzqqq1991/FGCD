startTime = clock;

dir1 = 'D:\ZhangQian\fineChangeDetection20150109\result\Parallel\DH\25-3\';%����Ŀ¼
dir2 = 
%��ȡ����
im1names = {'Xlighted-1'};
im2names = {'2'};

 
% %���ò���
% [h,w,dim] = size(imread([dir im1names{1} '.bmp']));
% diagonal = (h^2+w^2)^0.5;
% paramrate = ((772^2+515^2)^0.5)/diagonal;
% separate = 1;%����lrrʱÿ��ͼ�񵥶���
% functionnum = 2;%����lrr�����Է������õķ�����1��������2��cgs��3��symmlq��4��lsqr��5��rref
% lambda = 0.0015*paramrate;  %data���ϵ�� big:0.0015,middle:0.003,mini:0.006;
% gama = 0.0025*paramrate; %WE���ϵ�� big:0.0025,middle:0.005,mini:0.01;
% rou = 0.02*paramrate;%ǿ����ϵ��
    
%parameter����
parameter = [];
% parameter.separate = separate;
% parameter.functionnum = functionnum;
% parameter.lambda = lambda;
% parameter.gama = gama;
% parameter.display = true;
parameter.pieceWidth = 400;
parameter.pieceHeight = 300;
parameter.crossrate = 0.2;
parameter.lambda = 0.0015;  % ֵԼ�󣬵õ��ı仯Խ��
parameter.gama = 0.0025;
%��ʼ
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

%��ʱ������ͳ��ʱ��
endTime = clock;
duringTime = etime(endTime,startTime);
disp(['Total Time is: ' num2str(duringTime) ' second']); 


imwrite(EX, 'EX.bmp');
imwrite(EY, 'EY.bmp');
imwrite(AX, 'AX.bmp');
imwrite(AY, 'AY.bmp');