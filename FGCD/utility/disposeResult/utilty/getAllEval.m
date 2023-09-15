function eval  = getAllEval( label,GT )

    evltypes = char('fmeasure','Re','Precision','Sp','FP', 'FN' ,'FPR','FNR','pwc');
%     methodNum = 7;
    methodNum = length(evltypes);
    eval = zeros(methodNum,1);
    
    for i = 1:methodNum
        type = strtrim(evltypes(i,:));
        eval(i) = GetEvaluation(label,GT,1,type);
        %disp([type ' : ' num2str(eval(i))]);
    end
end

