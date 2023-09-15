function uvflow_resize = resizeUVflow(uvflow,scale,methodstr)
%RESIZEUVFLOW 此处显示有关此函数的摘要
%   此处显示详细说明
    if nargin < 2
        scale = 0.5;
    elseif nargin < 3
        methodstr = 'bicubic';
    end
    
    [oh,ow,dim] = size(uvflow);
    if isscalar(scale)
        height = round(oh * scale);
        width = round(ow * scale);
        ratiox = scale;
        ratioy = scale;
    else 
        height = scale(1);
        ratiox = height / double(oh);
        width = scale(2);
        ratioy = width / double(ow);
    end
    
    
    flow_x = uvflow(:,:,1);
    flow_y = uvflow(:,:,2);
    % 将大小resize并将数值resize
    flow_x = imresize(flow_x,[height,width],methodstr) * ratiox;
    flow_y = imresize(flow_y,[height,width],methodstr) * ratioy;
    uvflow_resize(:,:,1) = flow_x;
    uvflow_resize(:,:,2) = flow_y;
end

