function [ im3, T ] = lightingCorrection( im1_im2doubled, im2_im2doubled, parameter)
%LIGHTINGCORRECTION ����һ�»�����
% parameter.lambda; %%�ò���Խ�󣬱仯Խ���ԣ�������Խ�Ĭ��0.1
% parameter.updateColorDiffItemWeight = 'lastE'; %lastE,null�� lastE
% parameter.fai_E;  %�ò���Խ�󣬱仯Խ���ԣ�������Խ� ����ֵ��ͼ��Խ��߳������
% parameter.lastE  %�ϴεõ���E��Ϊ�������ṩ����
% parameter.Omega %ǿ����ͬ�����Ȩ�ء�Ĭ��1
% parameter.GivenT %ǿ��������
% parameter.interNum; �ڲ�����������Ĭ��1
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
    parameter.fai_E = 150*paramrate;  %�ò���Խ�󣬱仯Խ���ԣ�������Խ��
else
    parameter.fai_E = paramrate*parameter.fai_E;
end
if ~isfield(parameter,'Omega')
    parameter.Omega = 150*paramrate;  %�ò���Խ�󣬱仯Խ���ԣ�������Խ��
else
    parameter.Omega = paramrate*parameter.Omega;
end
if ~isfield(parameter, 'GivenT')  %����Ҫ��λ����Ϊ100���������㲻�����ȥ
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

    
    
        %%%%%%%%%���²���
    parameter.lastE = im3-im2_im2doubled;
    
end


end

