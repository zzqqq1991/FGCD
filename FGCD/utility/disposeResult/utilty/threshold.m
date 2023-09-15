dirList =  char('goldBuddha1','goldBuddha2','goldBuddha3','goldBuddha4','goldBuddha5','twoBuddha1','twoBuddha2','twoBuddha3','twoBuddha4','twoBuddha5','westwall1','westwall2','westwall3');
imageList = char('E_1', 'E_2','E_3', 'E_4','E_5');
for dirnum = 1 : 13
    for i = 1:5
        thres = 0.02;
        for j = 1:3
            dir = ['./data/' strtrim(dirList(dirnum,:)) '/'];
            file = imageList(i,:);
            fullname = [dir file '.bmp'];
            image = imread(fullname);
            diff = im2bw(image, thres);
            imwrite(diff,[dir file '_' num2str(thres) '.bmp']);
            thres = thres + 0.01;
        end 
    end
end
 