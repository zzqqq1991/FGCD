function h = PRROC(TrueLabel,decisions,posVal,ROC_PR)
%PRROC ����PR���߻���ROC����
% posVal :positive label��ֵ��SVM�е�0����1��Ӧ�ó�����TrueLabel��
% ROC_PR: 0 and 1 ,0 is PR, 1 is ROC

% h ���ص�figure���

if ROC_PR == 0
    [X,Y,T,AUC] = perfcurve(TrueLabel,decisions,posVal);
    h= figure;
    plot(X,Y)
    xlabel('False positive rate');
    ylabel('True positive rate');
    title('ROC Curve for classification by SVM');
    %saveas(h,figureName);
    
elseif ROC_PR == 1
    [X,Y,T,AUC] = perfcurve(TrueLabel,decisions,posVal,'xCrit','TPR','yCrit','PPV');
    h= figure;
    plot(X,Y)
    xlabel('Recall');
    ylabel('Percision');
    title('PR Curve for classification by SVM');
    %saveas(h,figureName);
end

end

