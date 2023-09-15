function [XError,XA] = ourGetErrorByLowRank_Multiple_W_singleInput(X,lastXA,lastXE,parameter)
%GETERRORBYLOWRANK_MULTIPLE 此处显示有关此函数的摘要
%   此处显示详细说明


    [height, width,  dim, imageNum] = size(X);
    XcolAll = reshape(X,height*width*dim,imageNum);

    O = [XcolAll];
    [A,E] = ourlrra_W(O,lastXA,lastXE, getW(height,width), parameter);

    XError = reshape(E,height,width,dim,imageNum);
    XA = reshape(A,height,width,dim,imageNum);

