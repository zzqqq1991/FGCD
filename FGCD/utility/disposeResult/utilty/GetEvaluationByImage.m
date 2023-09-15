function res = GetEvaluationByImage( labelImage,trueLabelImage,posVal,type )
% ������Ϊlabelͼ�������µĵõ�Evaluation
% labelImage: Ԥ���labelImage
% trueLabelImage: Ground True Image
% posVal: ������ֵ��һ��Ϊ1
% type: ���ͣ�fmeasure, recall, precision,Sp,FPR,FNR,pwc

[height, width]  =  size(trueLabelImage);
% ��GT reshape��vector
trueLabel= reshape(trueLabelImage,[height*width,1]);
% �������label reshape ��vector
label = reshape(labelImage,[height*width,1]);
% ����GetEvaluation
res = GetEvaluation(label,trueLabel,posVal,type);

end

