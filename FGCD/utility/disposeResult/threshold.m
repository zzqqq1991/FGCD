%zq
function [result] = threshold (OCAll, cutthreshold)
% cutthreshold = 0.1200;
% OCAll = imread('OCAll.bmp');
OCAll = im2double(OCAll);
tempmax = max(OCAll(:));
tempocall = OCAll./tempmax;
OCAll_threshold = all(tempocall>cutthreshold,3);

% imwrite(OCAll_threshold, [ 'differThreshold_thres ' '.bmp']);
result = OCAll_threshold;
end
% % ¼ÆËãf1Öµ
% mask = imread('mask.bmp');
% GT = imread('GT.bmp');
% GT=GT.*mask;
% eval  = getAllEval( OCAll_threshold, GT);
% display(eval);

% imwrite(OCAll_threshold, [ 'differThreshold_thres ' num2str(cutthreshold) '_F1 ' num2str(eval(1)) '.bmp']);


% tempmax = max(OC(:));
% tempocall = OC./tempmax;
% OC_threshold = all(tempocall>cutthreshold,3);
% imwrite(OC_threshold, [resultDir 'OC_easy_thres_labeled.bmp']);
%zq