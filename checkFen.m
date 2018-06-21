function correct = checkFen(fen, i)
    
    %% caricamento stringhe fen corrette
    strApp = sprintf('./stringheFen/%03d.txt', i); %s per stringa
    fFen = fopen(strApp);
    originalFen = fscanf(fFen, '%c');
    
    % controllo se sono uguali
    correct = strcmp(originalFen, fen);
end