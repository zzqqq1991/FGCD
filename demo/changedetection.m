function [ imresult, changeresult ] = changedetection( path1, path2, subsize, cutthreshold )
% index = 2;
maskpath = ''; % set '' if have no mask

pyramidrate = {1};

im1names = {path1};
im2names = {path2};
% im1names = {'1-1'};
% im2names = {'2-1'};
%%

X = [];
Y = [];
for i = 1:length(im1names)
    im1 = imread([im1names{i}]);
    im1 = im2double(im1);
    im1 = imresize(im1, subsize);
    X(:,:,:,i) = im1;
    im2 = imread([im2names{i}]);
    im2 = im2double(im2);
    im2 = imresize(im2, subsize);
    Y(:,:,:,i) = im2;
end

imh = size(X, 1);
imw = size(X, 2);

[ parameterflow, parameterlight, parameterdetection ] = getAllParameter();  % set all params

if size(maskpath) > 0
    mask = imread(maskpath);
    mask = imresize(mask, subsize);
    mask = all(mask>0,3);
    parameterflow.mask = mask;
    parameterlight.mask = mask;
    parameterdetection.mask = mask;
end


tempX = X;
tempY = Y;
for i = 1:length(pyramidrate)

    rate = pyramidrate{i};
    tempX = resizeData(X, floor(imh*rate), floor(imw*rate));
    tempY = resizeData(Y, floor(imh*rate), floor(imw*rate));
    result  = FlowLightingDetection( tempX, tempY, parameterflow, parameterlight, parameterdetection );
end

imresult =  result.Xlighted(:,:,:,1);

% cutthreshold = 0.4;

fusionparam = 1;
changeresult = changedetecionthreshold(imresult, Y, cutthreshold, fusionparam);

% changeresult  = threshold (abs(imresult-Y), cutthreshold);

end



