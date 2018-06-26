function [confMat, correct] = confusionMat( results,a,b)
    l=(b-a+1);
    confMat=zeros(13,13);
    labels= double('aKkQqRrBbNnPp');
    indexs= {'blank','K' ,'k' ,'Q' ,'q','R', 'r', 'B', 'b', 'N', 'n' ,'P','p'};
    correct = 0;
    for(i=1 : l)
        strApp = sprintf('./stringheFen/%03d.txt', a+i-1);
        fFen = fopen(strApp);
        fenOriginale = fscanf(fFen, '%c');
        fenOriginale = fenOriginale(1:end-1);

        predicted= double(expandFen(fenOriginale));
        result= double(expandFen(results{i}));
        
        f = strcmp(fenOriginale, results{i});
        if f == 1
            correct = correct + 1;
        end
    
        %% generazione matrice di confusione
        confMat = confMat + confusionmat(predicted,result, 'order',labels);
    end
    
    for i = 1 : size(confMat,1)
        if sum(confMat(i, :)) ~= 0
            confMat(i, :)= confMat(i, :) ./ sum(confMat(i, :));
        end
    end
    
    app = cell(14);
    app(1, 2:end) = indexs;
    app(2:end, 1) = indexs';
    app(2:end, 2:end) = num2cell(confMat(1:end, 1:end));
   
    confMat = app;
    
end

