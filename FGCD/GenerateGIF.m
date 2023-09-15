function [ ] = GenerateGIF( im1,im2, filename)
[I1,map] = rgb2ind(im1,256);
imwrite(I1,map,filename,'gif','Loopcount',Inf,'DelayTime',0.5);
[I2,map] = rgb2ind(im2,256);
imwrite(I2,map,filename,'gif','WriteMode','append','DelayTime',0.5);
end

