function writeAllImages(ImageList,dir,prefix)
%WRITEIMAGEFILES ���ض��ļ�������һ����ʽ����д����ͼ��
%������ʽ�� prefix-middleName-iteration.bmp

num = size(ImageList,4);
for i = 1 : num
    imwrite(ImageList(:,:,:,i), [dir prefix '-' num2str(i) '.jpg']);
end

end

