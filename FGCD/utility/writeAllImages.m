function writeAllImages(ImageList,dir,prefix)
%WRITEIMAGEFILES 在特定文件夹下以一定方式命名写入多幅图像
%命名方式： prefix-middleName-iteration.bmp

num = size(ImageList,4);
for i = 1 : num
    imwrite(ImageList(:,:,:,i), [dir prefix '-' num2str(i) '.jpg']);
end

end

