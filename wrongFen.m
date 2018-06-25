function risultato = wrongFen(fen, k)
    strApp = sprintf('./stringheFen/%03d.txt', k);
    fFen = fopen(strApp);
    fenOriginale = fscanf(fFen, '%c');
    
    fenOEx= '';
    
    l = length(fenOriginale)-6;
    for i = 1 : l 
        num = str2num(fenOriginale(i));
        if (isempty(num) == 0)
            for j = 1 : num
                fenOEx = strcat(fenOEx, 'a');
            end
        else
            if fenOriginale(i) ~= '/'
            fenOEx = strcat (fenOEx, fenOriginale(i));
            end
        end
    end
    
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