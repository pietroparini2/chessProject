function risultato = checkFen(fen)
    
    %% caricamento stringhe fen corrette
    correctFen = load('correctFen.mat');
    correctFen = correctFen.correctFen;
    
    %% controllo se esiste una stringa uguale
    correct = 0;
    
    app = union(fen, correctFen);
    if length(app) == 8
        correct = 1;
    end
        
    risultato = correct;
end