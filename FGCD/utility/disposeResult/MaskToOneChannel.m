function [result] = MaskToOneChannel (im)
% im = imread('mask.bmp');
im = im2double(im);

result = all(im>0,3);
% imshow(temp);
% imwrite(temp,'result.bmp');
end
