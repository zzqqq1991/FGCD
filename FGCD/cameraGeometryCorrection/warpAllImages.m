function XWarped = warpAllImages(Y, X,uvflow)
%WARPALLIMAGES warp¶à·ùÍ¼Ïñ
    [height,width,dim,num] = size(X);
    XWarped = zeros(height,width,dim,num);
    for i =  1 : num
        XWarped(:,:,:,i) = warpFLColor(Y(:,:,:,i), X(:,:,:,i),uvflow(:,:,1),uvflow(:,:,2));
    end
end

