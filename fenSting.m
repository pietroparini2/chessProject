function  [fen, percentualeR] = fenString(indici, nImg)
    indici = reshape(indici', 1, 64);
    
    %% sostituisco gli indici con le lettere corrispondenti ai pezzi
    str(indici == 17 | indici == 18 | indici == 31 | indici == 32) = 'a'; 
    
    % pezzi neri (prima su nero poi su bianco)
    str(indici == 1 | indici == 2) = 'k';
    str(indici == 3 | indici == 19 | indici == 20) = 'q';
    str(indici == 4 | indici == 21) = 'r';
    str(indici == 5 | indici == 22) = 'b';
    str(indici == 6 | indici == 23) = 'n';
    str(indici == 7 | indici == 24) = 'p';
    
    % pezzi bianchi (prima su nero poi su bianco)
    str(indici == 8 | indici == 25) = 'K';
    str(indici == 9 | indici == 10 | indici == 26) = 'Q';
    str(indici == 11 | indici == 12 | indici == 27) = 'R';
    str(indici == 13 |indici == 14 | indici == 28) = 'B';
    str(indici == 15 | indici == 29) = 'N';
    str(indici == 16 | indici == 30) = 'P';
    
    [fen, percentualeR] = fenStringApp(str, nImg);
    
    if percentualeR == 0
        percentualeR = wrongFen(str, nImg);
    end  
    
    
end