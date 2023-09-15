function [XError,YError,XA,YA] = ourGetErrorByLowRank_Multiple(X,Y,lambda)
%GETERRORBYLOWRANK_MULTIPLE 此处显示有关此函数的摘要
%   此处显示详细说明

% [height, width,  dim,imageNum] = size(X);
% XcolAll = reshape(X,height*width*dim,imageNum);
% YcolAll = reshape(Y,height*width*dim,imageNum);
% 
% O = [XcolAll YcolAll];
% [A,E] = ourlrra(O,lambda,true);
% 
% XError = reshape(E(:,1:imageNum),height,width,dim,imageNum);
% YError = reshape(E(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
% 
% XA = reshape(A(:,1:imageNum),height,width,dim,imageNum);
% YA = reshape(A(:,imageNum+1:2*imageNum),height,width,dim,imageNum);

separate =1;

if separate == 1
    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);
    YcolAll = reshape(Y,height*width*dim,imageNum);
    for i = 1:imageNum
        O = [XcolAll(:,i), YcolAll(:,i)];
        [Z,E] = ourlrra(O,lambda,true);
        XError(:,:,:,i) = reshape(E(:,1),height,width,dim);
        YError(:,:,:,i) = reshape(E(:,2),height,width,dim);
        XA(:,:,:,i) = reshape(Z(:,1),height,width,dim);
        YA(:,:,:,i) = reshape(Z(:,2),height,width,dim);
    end
else
    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);
    YcolAll = reshape(Y,height*width*dim,imageNum);

    O = [XcolAll YcolAll];
    [Z,E] = ourlrra(O,lambda,true);

    XError = reshape(E(:,1:imageNum),height,width,dim,imageNum);
    YError = reshape(E(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
    XA = reshape(Z(:,1:imageNum),height,width,dim,imageNum);
    YA = reshape(Z(:,imageNum+1:2*imageNum),height,width,dim,imageNum);
    
end

