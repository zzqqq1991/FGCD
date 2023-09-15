function [ W ] = createW1(imh,imw,parameter)
%CREATEW1 此处显示有关此函数的摘要
%   此处显示详细说明
if strcmp(parameter.updateColorDiffItemWeight,'lastE')
    error = parameter.lastE;
    fai = parameter.fai_E;
    error = abs(error);
    W =exp(-error.*fai);
elseif strcmp(parameter.updateColorDiffItemWeight,'flowedS')
    flowedS = parameter.flowedS;
    fai = parameter.fai_S;
    templeft = flowedS;
    tempright = flowedS;
    temptop = flowedS;
    tempbottom = flowedS;
    templeft(:,2:end,:,:) = flowedS(:,1:end-1,:,:);
    tempright(:,1:end-1,:,:) = flowedS(:,2:end,:,:);
    temptop(2:end,:,:,:) = flowedS(1:end-1,:,:,:);
    tempbottom(1:end-1,:,:,:) = flowedS(2:end,:,:,:);
    temp=(flowedS - templeft).^2 + (flowedS - tempright).^2+(flowedS - temptop).^2+(flowedS - tempbottom).^2;
    temp = temp/4;
    temp = sum(temp,3);
    W = exp(-temp.*fai);
%     W = repmat(W,[1,1,3]);
elseif strcmp(parameter.updateColorDiffItemWeight,'lastT')
    lastT = parameter.lastT;
    fai = parameter.fai_T;
    templeft = lastT;
    tempright = lastT;
    temptop = lastT;
    tempbottom = lastT;
    templeft(:,2:end,:) = lastT(:,1:end-1,:);
    tempright(:,1:end-1,:) = lastT(:,2:end,:);
    temptop(2:end,:,:) = lastT(1:end-1,:,:);
    tempbottom(1:end-1,:,:) = lastT(2:end,:,:);
    temp=abs(lastT - templeft) + abs(lastT - tempright)+abs(lastT - temptop)+abs(lastT - tempbottom);
    temp = temp/4;
    W =exp(-temp.*fai);
else  %默认为null
    W = ones(imh,imw,1);
end

end

