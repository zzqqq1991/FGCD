function [ A2, b2 ] = getAbOfItem2(im1_im2double,im2_im2double,parameter)
%GETABOFITEM2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[imh,imw,imdim] = size(im1_im2double);
MatrixW = imh*imw*imdim;
% [indexrow, indexcol,Sweight] = createW2(imh,imw,parameter);
[indexrow, indexcol] = createW2_C(imh,imw);
indexrow = indexrow';
indexcol = indexcol';
Sweight = ones(size(indexrow));
mask = parameter.mask;
mask = mask(:);
maskindexrow = mask(indexrow);
maskindexcol = mask(indexcol);
% Sweightmask1 = maskindexrow.*indexrow;
% Sweightmask2 = maskindexcol.*indexcol;

Sweight = Sweight.*maskindexrow.*maskindexcol;

sparseweight=sparse(indexrow, indexcol, Sweight, imh*imw, imh*imw);
rowSum=sum(sparseweight, 2);
colSum=sum(sparseweight, 1);

sparsematrix1 = sparse(1 : imh*imw, 1:imh*imw, rowSum, imh*imw, imh*imw);
sparsematrix2 = sparse(1 : imh*imw, 1:imh*imw, colSum, imh*imw, imh*imw);
% A2=spdiags(rowSum, 0, imh*imw, imh*imw)+spdiags(colSum', 0, imh*imw, imh*imw)-sparseweight-sparseweight';
A2temp = sparsematrix1 + sparsematrix2 - sparseweight - sparseweight';
clear sparsematrix1 sparsematrix2 sparseweight sparseweight;
clear colSum im1_im2double im2_2double imh imw indexcol indexrow rowSum Sweight;
%��A2�ضԽ������MatrixW*MatrixW�ľ���
A2 = [];
for i=1:imdim
    A2 = blkdiag(A2,A2temp);
end
% A2 = blkdiag(A2);
%û��b2
b2 = zeros(MatrixW,1);
clear MatrixW;
end

