function fenEx = expandFen(fen)
    fenEx= '';
    
    l = length(fen)-6;
    for i = 1 : l 
        num = str2num(fen(i));
        if (isempty(num) == 0)
            for j = 1 : num
                fenEx = strcat(fenEx, 'a');
            end
        else
            if fen(i) ~= '/'
            fenEx = strcat (fenEx, fen(i));
            end
        end
    end
    
end

