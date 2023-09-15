function uvflow_resize = resizeUVflow(uvflow,scale,methodstr)
%RESIZEUVFLOW �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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
    % ����Сresize������ֵresize
    flow_x = imresize(flow_x,[height,width],methodstr) * ratiox;
    flow_y = imresize(flow_y,[height,width],methodstr) * ratioy;
    uvflow_resize(:,:,1) = flow_x;
    uvflow_resize(:,:,2) = flow_y;
end

