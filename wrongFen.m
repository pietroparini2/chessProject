function risultato = wrongFen(fen, k)
    strApp = sprintf('./stringheFen/%03d.txt', k);
    fFen = fopen(strApp);
    fenOriginale = fscanf(fFen, '%c');
    
    fenOEx= expandFen(fenOriginale);
    confronto = fen == fenOEx;
    
    risultato{1} = (sum(confronto)*100)/64; 
    
    str = '';
    f = 1;
    for i = 1 : length(fen)
        if confronto(i) == 0 && f == 0
            app = sprintf(', %s -> %s',fen(i), fenOEx(i));
            str = strcat(str, app);
        else
            if confronto(i) == 0
            app = sprintf('%s -> %s',fen(i), fenOEx(i));
            str = strcat(str, app);
            f = 0;
            end    
        end
            
            
    end
    risultato{2} = str;
end