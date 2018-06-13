function  out = fenString(indici)
    indici = reshape(indici', 1, 64);
    
    %% sostituisco gli indici con le lettere corrispondenti ai pezzi
    str(indici == 25 | indici == 26 | indici == 27 | indici == 28 | indici == 30) = 'a'; 
    
    str(indici == 13 | indici == 14) = 'K';
    str(indici == 15 | indici == 16) = 'Q';
    str(indici == 17 | indici == 18) = 'R';
    str(indici == 19 | indici == 20) = 'B';
    str(indici == 21 | indici == 22) = 'N';
    str(indici == 23 | indici == 24) = 'P';
    
    str(indici == 1 | indici == 2) = 'k';
    str(indici == 3 | indici == 4) = 'q';
    str(indici == 5 | indici == 6) = 'r';
    str(indici == 7 | indici == 8) = 'b';
    str(indici == 9 | indici == 10) = 'n';
    str(indici == 11 | indici == 12) = 'p';
    
    out = fenStringApp(str);
end