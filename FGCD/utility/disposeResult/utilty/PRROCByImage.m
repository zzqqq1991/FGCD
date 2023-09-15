function h = PRROCByImage(TrueLabelImage,DecisionImage,posVal,ROC_PR)
%PRROCBYIMAGE 功能与PRROC相似，输入中TrueLabelImage和DecisionImage为height * width 的矩阵
%
[height, width]  =  size(TrueLabelImage);
trueLabel = reshape(TrueLabelImage,[height*width,1]);
decision = reshape(DecisionImage,[height*width,1]);
h = PRROC(trueLabel,decision,posVal,ROC_PR);

end

