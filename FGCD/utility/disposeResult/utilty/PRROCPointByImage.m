function [X,Y,T,AUC] = PRROCPointByImage( TrueLabelImage,DecisionImage,posVal,ROC_PR )

[height, width]  =  size(TrueLabelImage);
TrueLabel = reshape(TrueLabelImage,[height*width,1]);
decision = reshape(DecisionImage,[height*width,1]);
% ROC
if ROC_PR == 0
    [X,Y,T,AUC] = perfcurve(TrueLabel,decision,posVal);

% PR    
elseif ROC_PR == 1
    [X,Y,T,AUC] = perfcurve(TrueLabel,decision,posVal,'xCrit','TPR','yCrit','PPV');
end

end

