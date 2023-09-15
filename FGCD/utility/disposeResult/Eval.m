function [eval] = Eval (mask, GT, OCAll_labeled)

% addpath('utilty');
% mask = imread('mask.bmp');
% GT = imread('GT.bmp');
% imwrite(GT,'GT.bmp');
GT=GT.*mask;
% OCAll_labeled = imread('OCAll_easy_thres_labeled.bmp');
OCAll_labeled = OCAll_labeled.*mask;
eval  = getAllEval( OCAll_labeled,GT );
% save('eval.mat','eval');
end