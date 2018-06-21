function percentuale = wrongFen(fen)
    
    %% caricamento stringhe fen corrette
    extendedFen = load('extendedFen.mat');
    extendedFen = extendedFen.extendedFen;
    maxResult  = 0;
    for i = 1 : length(extendedFen)
        result = fen == extendedFen{i};
        result = sum(result);
        if result > maxResult
            maxResult = result;
        end
    end
    percentuale = (sum(maxResult)*100)/64; 
end