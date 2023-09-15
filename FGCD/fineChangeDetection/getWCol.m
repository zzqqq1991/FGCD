function [ indexrow, indexcol,Sweight, num ] = getWCol( height,width)
%CREATEW2 此处显示有关此函数的摘要
%   此处显示详细说明
indexrow = zeros(2*(height-1)*(width-1),1);
indexcol = zeros(2*(height-1)*(width-1),1);
Sweight = ones(2*(height-1)*(width-1),1);
num = 0;
ah = [1,0];
aw = [0,1];
for i = 1:height
    for j=1:width
        for k = 1:2  
            ni = i + ah(k);
            nj = j + aw(k);
            if(ni <= height && nj <= width)
                num = num + 1;
                indexi = (j-1)*height+i;     %(i,j)点展开后的下标
                indexj = (nj-1)*height+ni; %(i,j)相邻点展开后的下标(右方或下方）  
                indexrow(num) = indexi;
                indexcol(num) = indexj;
                %%%设权重
                Sweight(num) = 1;
                %%%设权重结束
            end
            
        end
    end
end
% indexrow2 = indexrow1 + height;
% indexcol2 = indexcol1 + width;
% 
% indexrow3 = indexrow1 + 2*height;
% indexcol3 = indexcol1 + 2*width;
% 
% indexrow=[indexrow1;indexrow2;indexrow3];
% indexcol=[indexcol1;indexcol2;indexcol3];
% Sweight = [Sweight1;Sweight1;Sweight1];
% 
% num = num * 3;

end

