function h = PRROCByImage(TrueLabelImage,DecisionImage,posVal,ROC_PR)
%PRROCBYIMAGE ������PRROC���ƣ�������TrueLabelImage��DecisionImageΪheight * width �ľ���
%
[height, width]  =  size(TrueLabelImage);
trueLabel = reshape(TrueLabelImage,[height*width,1]);
decision = reshape(DecisionImage,[height*width,1]);
h = PRROC(trueLabel,decision,posVal,ROC_PR);

end

