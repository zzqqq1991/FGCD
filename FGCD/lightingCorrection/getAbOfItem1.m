function [ A1,b1 ] = getAbOfItem1(im1_im2double,im2_im2double,parameter)
%GETABOFITEM1 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[imh,imw,imdim] = size(im1_im2double);

%����ϵ������
w = createW1(imh,imw,parameter);%m*n*1
w = w.*repmat(parameter.mask, 1,1,imdim);
w = w(:);
MatrixW = imh*imw*imdim;
index = 1:1:MatrixW;
A1=sparse(index, index, w', MatrixW, MatrixW);
% A1 = A1.*(1-exp(-parameter.Decline_t * parameter.fai_Decline));

changeim = im1_im2double - im2_im2double;
changeim_vec = changeim(:);
b1 = (2*changeim_vec).*w;
% b1 = b1.*(1-exp(-parameter.Decline_t * parameter.fai_Decline));
end

