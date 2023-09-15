function [ PP ] = pos( A )
%POS 此处显示有关此函数的摘要
%   此处显示详细说明
PP = A .* double(A>0);

end

