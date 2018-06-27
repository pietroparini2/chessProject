function risultato = checkFen(fen, i)
    
    %% caricamento stringhe fen corrette
    strApp = sprintf('./stringheFen/%03d.txt', i);
    fFen = fopen(strApp);
    originalFen = fscanf(fFen, '%c');
    
    %% controllo se sono uguali
    risultato = strcmp(originalFen(1:end-1), fen);
    
    if risultato == 1
        risultato = 100;
    end
end