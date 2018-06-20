function percentuale = wrongFen(fen)
    
    %% caricamento stringhe fen corrette
    extendedFen = load('extendedFen.mat');
    extendedFen = extendedFen.extendedFen;
    maxResult  = 0;
    for i = 1 : 8
        result = fen == extendedFen{i};
        result = sum(result);
        if result > maxResult
            maxResult = result;
        end
    end
    percentuale = sum(maxResult)/64; 
end