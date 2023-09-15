function result = ErrorAnd(OAll,thres,ratio)
%ERRORAND ������Ϊ����ͼ��ʱ��ͨ��ͳ��ÿ��ͼ����
%   �˴���ʾ��ϸ˵��
if nargin < 2
    ratio = 0.5;
end
[height,width,imageNum] = size(OAll);
Num =  zeros(height,width,imageNum,'uint8');
tsize = uint32(imageNum * ratio);
for i =  1 : imageNum
    Num(:,:,i) = all(OAll(:,:,i) > thres,3);
end

total = sum(Num,3);
result = all(total > tsize,3);

end

