savedir = 'E:\zq\PAMI data\Dd\465-1';

mkdir(savedir);

for i = 1:13
   
    imname = ['image' int2str(i) '.jpg'];
    savename = [savedir '\2-' int2str(i) '.jpg'];
    copyfile(imname, savename);
    
end
