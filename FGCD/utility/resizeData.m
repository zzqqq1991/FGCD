function [ result ] = resizeData( A, h, w )
%RESIZEDATA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

result = [];

if size(A,4) == 1
    result = imresize(A, [h,w]);
else
    for i = 1:size(A,4)
        result(:,:,:,i) = imresize(A(:,:,:,i), [h,w]);
    end
end

end

