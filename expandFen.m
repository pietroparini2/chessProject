function fenOEx = expandFen(fenOriginale)
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
    
end

