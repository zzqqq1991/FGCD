function [ A3, b3 ] = getAbOfItem3(im1_im2double,im2_im2double,parameter)
[imh,imw,imdim] = size(im1_im2double);

%¼ÆËãÏµÊý¾ØÕó
givenT = parameter.GivenT;
givenT = givenT.*repmat(parameter.mask, 1,1,imdim);
givenT = givenT(:);
givenTmask = all(givenT>-10, 3);
MatrixW = imh*imw*imdim;
index = 1:1:MatrixW;
A3=sparse(index, index, givenTmask', MatrixW, MatrixW);
% A1 = A1.*(1-exp(-parameter.Decline_t * parameter.fai_Decline));

b3 = (-2*givenTmask.*givenT);
end