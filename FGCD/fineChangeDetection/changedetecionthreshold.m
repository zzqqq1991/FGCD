function [ tresresult ] = changedetecionthreshold( im1, im2, thresparam, fuseparam )

im1 = im2double(im1);
im2 = im2double(im2);
Error = abs(im1 - im2);

Error = rgb2gray(Error);
[h,w,~] = size(Error);
% fuse

if fuseparam ~= 0
    
%     tempError = Error;
%     for i = 1:fuseparam
%         for j = 1:fuseparam
%        
%             
%             tempError() = tempError + Error(i:end,);
%             
%         end
%     end
    errorL = Error;
    errorL(1:end-fuseparam,:) = Error(1+fuseparam:end,:);
    errorR = Error;
    errorR(1+fuseparam:end,:) = Error(1:end-fuseparam,:);
    errorT = Error;
    errorT(:,1:end-fuseparam) = Error(:,1+fuseparam:end);
    errorB = Error;
    errorB(:,1+fuseparam:end) = Error(:,1:end-fuseparam);
    Error = (Error + errorL + errorR + errorT + errorB) ./ 4;
end

maxvalue = max(Error(:));
Error = Error./maxvalue;

tresresult = all(Error>thresparam, 3);

end

