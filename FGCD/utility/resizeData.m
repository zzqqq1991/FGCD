function [ result ] = resizeData( A, h, w )
%RESIZEDATA 此处显示有关此函数的摘要
%   此处显示详细说明

result = [];

if size(A,4) == 1
    result = imresize(A, [h,w]);
else
    for i = 1:size(A,4)
        result(:,:,:,i) = imresize(A(:,:,:,i), [h,w]);
    end
end

end

