% function [ indexrow1, indexcol1,Sweight1,Sweight2,Sweight3, num ] = createW2( height,width,parameter)
function [ indexrow1, indexcol1,Sweight1, num ] = createW2( height,width,parameter)
%CREATEW2 此处显示有关此函数的摘要
%   此处显示详细说明
indexrow1 = zeros(2*(height-1)*(width-1),1);
indexcol1 = zeros(2*(height-1)*(width-1),1);
Sweight1 = ones(2*(height-1)*(width-1),1);
Sweight2 = ones(2*(height-1)*(width-1),1);
Sweight3 = ones(2*(height-1)*(width-1),1);
num = 0;
ah = [1,0];
aw = [0,1];
for i = 1:height-1
    for j=1:width-1
        for k = 1:2
            num = num + 1;
            ni = i + ah(k);
            nj = j + aw(k);
            indexi = (j-1)*height+i;     %(i,j)点展开后的下标
            indexj = (nj-1)*height+ni; %(i,j)相邻点展开后的下标(右方或下方）  
            indexrow1(num) = indexi;
            indexcol1(num) = indexj;
            %%%设权重
%             if strcmp(parameter.updateSmoothItemWeight,'lastE')
%                 error = parameter.lastE;
%                 fai = parameter.fai_E;
%                 Sweight1(num) = (1-exp(-fai*(abs(error(i,j,1)-error(ni,nj,1)))));
%                 Sweight2(num) = (1-exp(-fai*(abs(error(i,j,2)-error(ni,nj,2)))));
%                 Sweight3(num) = (1-exp(-fai*(abs(error(i,j,3)-error(ni,nj,3)))));
%             elseif strcmp(parameter.updateSmoothItemWeight,'flowedS')
%                 flowedS = parameter.flowedS;
%                 fai = parameter.fai_S;
%                 temp=(flowedS(i,j,:)-flowedS(ni,nj,:)).^2;
%                 temp = sum(temp);
%                 Sweight1(num) =1-exp(-temp*fai);
%                 Sweight2(num) =1-exp(-temp*fai);
%                 Sweight3(num) =1-exp(-temp*fai);
%             elseif strcmp(parameter.updateSmoothItemWeight,'lastT')
%                 lastT = parameter.lastT;
%                 fai = parameter.fai_T;
%                 w1 =  (1-exp(-fai*(abs(lastT(i,j,1)-lastT(ni,nj,1)))));
%               
%                 w2 = (1-exp(-fai*(abs(lastT(i,j,2)-lastT(ni,nj,2)))));
%                 w3 = (1-exp(-fai*(abs(lastT(i,j,3)-lastT(ni,nj,3)))));
%                 Sweight1(num) =w1;
%                 Sweight2(num) = w2;
%                 Sweight3(num) = w3;
%             else  %默认为null
%                 Sweight1(num) = 1;Sweight2(num) = 1;Sweight3(num) = 1;
%             end
            %%%设权重结束
            
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

