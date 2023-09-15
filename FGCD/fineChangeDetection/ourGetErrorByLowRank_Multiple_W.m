function [XError,YError,XA,YA] = ourGetErrorByLowRank_Multiple_W(X,Y,lastXA,lastYA,lastXE,lastYE,parameter)
%GETERRORBYLOWRANK_MULTIPLE 此处显示有关此函数的摘要
%   此处显示详细说明

separate = parameter.separate;
if separate == 1
    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);
    YcolAll = reshape(Y,height*width*dim,imageNum);
    lastXA = imresize(lastXA, [height, width]);
    lastYA = imresize(lastYA, [height, width]);
    lastXE = imresize(lastXE, [height, width]);
    lastYE = imresize(lastYE, [height, width]);
    lastXAcolAll = reshape(lastXA,height*width*dim,imageNum);
    lastYAcolAll = reshape(lastYA,height*width*dim,imageNum);
    lastXEcolAll = reshape(lastXE,height*width*dim,imageNum);
    lastYEcolAll = reshape(lastYE,height*width*dim,imageNum);
    for i = 1:imageNum
        O = [XcolAll(:,i), YcolAll(:,i)];
        lastA = [lastXAcolAll(:,i), lastYAcolAll(:,i)];
        lastE = [lastXEcolAll(:,i), lastYEcolAll(:,i)];
        [A,E] = ourlrra_W(O,lastA, lastE, getW(height,width), parameter);
        XError(:,:,:,i) = reshape(E(:,1),height,width,dim);
        YError(:,:,:,i) = reshape(E(:,2),height,width,dim);
        XA(:,:,:,i) = reshape(A(:,1),height,width,dim);
        YA(:,:,:,i) = reshape(A(:,2),height,width,dim);
    end
else
    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);
    YcolAll = reshape(Y,height*width*dim,imageNum);

    O = [XcolAll YcolAll];
    [A,E] = ourlrra_W(O, getW(height,width), parameter);

    XError = reshape(E(:,1:imageNum),height,width,dim,imageNum);
    YError = reshape(E(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
    XA = reshape(A(:,1:imageNum),height,width,dim,imageNum);
    YA = reshape(A(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
end

