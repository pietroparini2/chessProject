function percentuale = wrongFen(fen, k)
    strApp = sprintf('./stringheFen/%03d.txt', k); %s per stringa
    fFen = fopen(strApp);
    originalFen = fscanf(fFen, '%c');
    originalFenEx= '';
    l = length(originalFen)-6;
    for i = 1 : l 
        num = str2num(originalFen(i));
        if (isempty(num)==0)
            for j = 1 : num
                originalFenEx = strcat(originalFenEx, 'a');
            end
        else
            if originalFen(i) ~= '/'
            originalFenEx = strcat (originalFenEx, originalFen(i));
            end
        end
    end
    
    
    result = fen == originalFenEx;
    percentuale = (sum(result)*100)/64; 




%     %% caricamento stringhe fen corrette
%     extendedFen = load('extendedFen.mat');
%     extendedFen = extendedFen.extendedFen;
%     maxResult  = 0;
%     for i = 1 : length(extendedFen)
%         result = fen == extendedFen{i};
%         result = sum(result);
%         if result > maxResult
%             maxResult = result;
%         end
%     end
%     percentuale = (sum(maxResult)*100)/64; 
end