function [bestthreshold, bestF1] = autofindbestF1 (mask, GT, OCAll)

addpath('utilty');
minthreshold = 0;
maxthreshold = 1;
step = 0.01;
bestthreshold = minthreshold;
bestF1 = 0;

% mask = imread('mask.bmp');
% GT = imread('GT.bmp');
GT=GT.*mask;
% OCAll = imread('OCAll.bmp');
OCAll = im2double(OCAll);
tempmax = max(OCAll(:));
tempocall = OCAll./tempmax;
tempocall = tempocall.*mask;
while minthreshold < maxthreshold
    minthreshold = minthreshold+step;
    OCAll_threshold = all(tempocall>minthreshold, 3);
    eval  = getAllEval( OCAll_threshold, GT);
    tempF1 = eval(1);
    
    if tempF1>bestF1
        bestF1 = tempF1;
        bestthreshold = minthreshold;
    end
end

% bestthreshold
% bestF1
% save('best.mat', 'bestthreshold', 'bestF1');

end