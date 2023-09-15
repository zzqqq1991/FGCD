function [ im3, T ] = lightingCorrection( im1_im2doubled, im2_im2doubled, parameter)
%LIGHTINGCORRECTION 光照一致化函数
% parameter.lambda; %%该参数越大，变化越明显，但整体越差。默认0.1
% parameter.updateColorDiffItemWeight = 'lastE'; %lastE,null， lastE
% parameter.fai_E;  %该参数越大，变化越明显，但整体越差。 参数值与图像对角线长度相关
% parameter.lastE  %上次得到的E，为数据项提供开关
% parameter.Omega %强制相同的项的权重。默认1
% parameter.GivenT %强制项数据
% parameter.interNum; 内部迭代次数，默认1
% parameter.mask

[h,w,d] = size(im1_im2doubled);
diagonal = (h^2+w^2)^0.5;
paramrate = diagonal / ((772^2+515^2)^0.5);

if nargin<3
    parameter = [];
end

if ~isfield(parameter, 'interNum')
    parameter.interNum = 1;
end
if ~isfield(parameter, 'mask')
    parameter.mask = ones(size(im1_im2doubled,1), size(im1_im2doubled, 2));
    parameter.mask = all(parameter.mask>0,3);
end
if ~isfield(parameter,'lambda')
    parameter.lambda = 0.1;
end
% if ~isfield(parameter,'updateColorDiffItemWeight')
    parameter.updateColorDiffItemWeight = 'lastE';
% end
if ~isfield(parameter,'lastE')
    parameter.lastE = zeros(size(im2_im2doubled));
end
if ~isfield(parameter,'fai_E')
    parameter.fai_E = 150*paramrate;  %该参数越大，变化越明显，但整体越差
else
    parameter.fai_E = paramrate*parameter.fai_E;
end
if ~isfield(parameter,'Omega')
    parameter.Omega = 150*paramrate;  %该参数越大，变化越明显，但整体越差
else
    parameter.Omega = paramrate*parameter.Omega;
end
if ~isfield(parameter, 'GivenT')  %不需要的位置设为100，后续计算不会算进去
    parameter.GivenT = -100*ones(size(im2_im2doubled));
end

% if ~isfield(parameter,'updateSmoothItemWeight')
%     parameter.updateSmoothItemWeight = 'null';
% end
% if ~isfield(parameter,'getS_param')
%     parameter.getS_param = 0.005;
% end
% if ~isfield(parameter,'getS_flowedIm1_im2doubled') || ~isfield(parameter,'getS_Im2_im2doubled')
%     parameter.flowedS = zeros([size(im1_im2doubled),2]);
% end
% if ~isfield(parameter,'fai_S')
%     parameter.fai_S = 30;
% end
% if ~isfield(parameter,'lastT')
%     parameter.lastT = zeros(size(im2_im2doubled));
% end
% if ~isfield(parameter,'fai_T')
%     parameter.fai_T = 30;
% end
% if ~isfield(parameter,'Decline_t')
%     parameter.Decline_t = 1;
% end
% if ~isfield(parameter,'fai_Decline')
%     parameter.fai_Decline = 30;
% end


for i = 1:parameter.interNum
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    [A1,b1] = getAbOfItem1(im1_im2doubled,im2_im2doubled,parameter);
    [A2,b2] = getAbOfItem2(im1_im2doubled,im2_im2doubled,parameter);
    [A3,b3] = getAbOfItem3(im1_im2doubled,im2_im2doubled,parameter);

    A = 2*(A1+ parameter.lambda*A2 + parameter.Omega*A3);
    b = -(b1+ parameter.lambda*b2 + parameter.Omega*b3);

    T_vec=A\b;
    % T_vec=A1\b1;

    T_vec = full(T_vec);
    T = reshape(T_vec,size(im1_im2doubled));
    im3 = im1_im2doubled + T;

    
    
        %%%%%%%%%更新参数
    parameter.lastE = im3-im2_im2doubled;
    
end


end

