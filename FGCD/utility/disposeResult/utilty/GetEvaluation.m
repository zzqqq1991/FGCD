function res = GetEvaluation(label,trueLabel,posVal,type)
% 在输入为label vector 的情况下的得到Evaluation
% labelImage: 预测的label Vector
% trueLabelImage: Ground True Vector
% posVal: 正样本值，一般为1
% type: 类型，fmeasure, recall, precision,Sp,FPR,FNR,PWC

posTrueIndex = trueLabel == posVal;
negTrueIndex = trueLabel ~= posVal;
posIndex = find(label == posVal);
negIndex = find(label ~= posVal);
P = length(posIndex);
N = length(negIndex);
TP = double(length(find(label(posTrueIndex) == posVal)));
TN = double(length(find(label(negTrueIndex) ~= posVal)));
FP = P - TP;
FN = N - TN;

percision = TP / (TP + FP);
recall  = TP / (TP + FN);

switch type
    case 'TP'
        res = TP;
    case 'FP'
        res = FP;
    case 'FN'
        res = FN;
    case 'TN'
        res = TN;
    case 'fmeasure'
        res = 2 * percision * recall / (percision + recall);
    case 'Re'
        res = recall;
    case 'Precision'
        res = percision;
    case 'Sp'
        res = TN / (TN + FP);
    case 'FPR'
        res = FP / (FP + TN);
    case 'FNR'
        res = FN / (TP + FN);
    case 'pwc'
        res = 100 * (FN + FP) / (TP + FN + FP + TN);
    otherwise
        disp('No this Type');

end

