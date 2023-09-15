function [  ] = showgif( img1, img2, pa )
%SHOWGIF 此处显示有关此函数的摘要
%   此处显示详细说明

h = figure(1);

while(1)
    if  ishandle(h) == false
        break;
    end
    for i=1:2
        if  ishandle(h) == false
            break;
        end
        imshow(img1);
        if  ishandle(h) == false
            break;
        end
        pause(pa);
        if  ishandle(h) == false
            break;
        end
        imshow(img2);
        if  ishandle(h) == false
            break;
        end
        pause(pa);
        if  ishandle(h) == false
            break;
        end
    end
end

end

