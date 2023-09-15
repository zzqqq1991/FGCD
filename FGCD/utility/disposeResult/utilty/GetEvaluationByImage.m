function res = GetEvaluationByImage( labelImage,trueLabelImage,posVal,type )
% 在输入为label图像的情况下的得到Evaluation
% labelImage: 预测的labelImage
% trueLabelImage: Ground True Image
% posVal: 正样本值，一般为1
% type: 类型，fmeasure, recall, precision,Sp,FPR,FNR,pwc

[height, width]  =  size(trueLabelImage);
% 将GT reshape成vector
trueLabel= reshape(trueLabelImage,[height*width,1]);
% 将分类的label reshape 成vector
label = reshape(labelImage,[height*width,1]);
% 调用GetEvaluation
res = GetEvaluation(label,trueLabel,posVal,type);

end

