function  out = fenString(indici)
    indici = reshape(indici', 1, 64);
    
    str(indici == 1 | indici == 26) = 'a'; 
    str(indici == 2 | indici == 14) = 'K';
    str(indici == 3 | indici == 15) = 'Q';
    str(indici == 4 | indici == 16 | indici == 27) = 'R';
    str(indici == 5 | indici == 17) = 'B';
    str(indici == 6 | indici == 18) = 'N';
    str(indici == 7 | indici == 19) = 'P';
    
    str(indici == 8 | indici == 20) = 'k';
    str(indici == 9 | indici == 21) = 'q';
    str(indici == 10 | indici == 22) = 'r';
    str(indici == 11 | indici == 23) = 'b';
    str(indici == 12 | indici == 24) = 'n';
    str(indici == 13 | indici == 25) = 'p';
    
    out = fenStringApp(str);
end