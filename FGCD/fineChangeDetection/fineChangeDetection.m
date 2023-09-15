function [XError,YError,XA,YA] = fineChangeDetection(X,Y,parameter)
%GETERRORBYLOWRANK_MULTIPLE 此处显示有关此函数的摘要
% separate = 1;%计算lrr时每对图像单独算
% functionnum = 2;%计算lrr中线性方程组用的方法，1：反除。2：cgs。3：symmlq。4：lsqr。5：rref
% lambda = 0.0015*paramrate;  %data项的系数 big:0.0015,middle:0.003,mini:0.006;
% gama = 0.0025*paramrate; %WE项的系数 big:0.0025,middle:0.005,mini:0.01;
% rou = 0.02*paramerate;%强制项系数
% givenEX givenEY; 强制项的data
% mask; 就是mask，单通道logical的
% display = true; 显示中间结果

% paramrate 求解。参数与图像对角线长度挂钩
% [h,w,dim] = size(im);
% diagonal = (h^2+w^2)^0.5;
% paramrate = ((772^2+515^2)^0.5)/diagonal;


[h,w,dim] = size(X(:,:,:,1));
diagonal = (h^2+w^2)^0.5;
paramrate = ((772^2+515^2)^0.5)/diagonal;

if nargin<3
    parameter = [];
end
if ~isfield(parameter, 'separate')
    parameter.separate = 1;
end
if ~isfield(parameter, 'functionnum')
    parameter.functionnum = 2;
end
if ~isfield(parameter, 'lambda')
    parameter.lambda = 0.0015*paramrate;
else
    parameter.lambda = parameter.lambda*paramrate;
end
if ~isfield(parameter, 'gama')
    parameter.gama = 0.0025*paramrate;
else
    parameter.gama = parameter.gama*paramrate;
end
if ~isfield(parameter, 'rou')
    parameter.rou = paramrate;
else
    parameter.rou = parameter.rou*paramrate;
end
if ~isfield(parameter, 'givenEX')
%     parameter.givenEX = -100*ones(size(X));
    parameter.givenEX = [];
end
if ~isfield(parameter, 'givenEY')
%     parameter.givenEY = -100*ones(size(Y));
    parameter.givenEY = [];
end
if ~isfield(parameter, 'mask')
%     parameter.mask = ones(h,w);
%     parameter.mask = all(parameter.mask>0,3);
    parameter.mask = [];
end
if ~isfield(parameter, 'display')
    parameter.display = true;
end

% 根据givenEX或givenEY得到系数矩阵
parameter.givenEcons = [];
if size(parameter.givenEX)>0
    tempgivenE = all(parameter.givenEX(:,:,:,1)>0, 4);
    tempgivenE = tempgivenE(:);
    tempgivenElength = length(tempgivenE);
    parameter.givenEcons = sparse(1:tempgivenElength, 1:tempgivenElength, tempgivenE, tempgivenElength, tempgivenElength);
end
% mask得到的系数矩阵
parameter.maskcons = [];
if size(parameter.mask)>0 
    if size(parameter.givenEX)>0
        tempmask = repmat(parameter.mask(:),[dim,1]);
        parameter.maskcons = sparse(1:tempgivenElength, 1:tempgivenElength, tempmask, tempgivenElength, tempgivenElength);
    end
end


separate = parameter.separate;

if separate == 1
    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);
    YcolAll = reshape(Y,height*width*dim,imageNum);
    givenEXcolAll = [];
    givenEYcolAll = [];
    if size(parameter.givenEX)>0
        givenEXcolAll = reshape(parameter.givenEX, height*width*dim,imageNum);
        givenEYcolAll = reshape(parameter.givenEY, height*width*dim,imageNum);
    end
    for i = 1:imageNum
        O = [XcolAll(:,i), YcolAll(:,i)];
        givenE = [];
        if size(parameter.givenEX)>0
            givenE = [givenEXcolAll(:,i), givenEYcolAll(:,i)];
        end
        [A,E] = ourlrra_W(O, getW(height,width,dim), givenE, parameter);
        XError(:,:,:,i) = reshape(E(:,1),height,width,dim);
        YError(:,:,:,i) = reshape(E(:,2),height,width,dim);
        XA(:,:,:,i) = reshape(A(:,1),height,width,dim);
        YA(:,:,:,i) = reshape(A(:,2),height,width,dim);
    end
else
    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);
    YcolAll = reshape(Y,height*width*dim,imageNum);
    givenEXcolAll = reshape(parameter.givenEX, height*width*dim,imageNum);
    givenEYcolAll = reshape(parameter.givenEY, height*width*dim,imageNum);
    O = [XcolAll YcolAll];
    givenE = [givenEXcolAll givenEYcolAll];
    [A,E] = ourlrra_W(O, getW(height,width,dim),givenE,parameter);

    XError = reshape(E(:,1:imageNum),height,width,dim,imageNum);
    YError = reshape(E(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
    XA = reshape(A(:,1:imageNum),height,width,dim,imageNum);
    YA = reshape(A(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
end

