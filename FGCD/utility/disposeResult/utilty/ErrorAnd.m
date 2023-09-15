function result = ErrorAnd(OAll,thres,ratio)
%ERRORAND 当输入为多张图像时，通过统计每张图像中
%   此处显示详细说明
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

