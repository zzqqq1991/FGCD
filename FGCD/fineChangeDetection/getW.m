function [ bigW ] = getW(imh, imw, dim)
%GETW 此处显示有关此函数的摘要
%   此处显示详细说明
[indexrow, indexcol,Sweight] = getWCol(imh,imw);
sparseweight=sparse(indexrow, indexcol, Sweight, imh*imw, imh*imw);

smallW = speye(imh*imw) - sparseweight - sparseweight';
% smallW=spdiags(rowSum, 0, imh*imw, imh*imw)+spdiags(colSum', 0, imh*imw, imh*imw)-sparseweight-sparseweight';

% bigW = blkdiag(smallW,smallW,smallW);
bigW = [];
for i = 1:dim
    bigW = blkdiag(bigW, smallW);
end

end

