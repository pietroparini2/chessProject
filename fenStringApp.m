function out = fenStringApp (indici)
    out = '';
    flag = 0;
    for i = 0 : 7
        count = 0;
        for j = 1 : 8
            if indici(j+(i*8)) == 'a' && flag == 1
                count = count +1;
            else 
                if indici(j+(i*8)) == 'a'
                    flag = 1;
                    count = 1;
                else
                    if flag == 1
                        out = strcat(out, num2str(count), indici(j+(i*8)));
                        count = 0;
                        flag = 0;
                    else
                        out = strcat(out, indici(j+(i*8)));
                    end 
                end
            end
        end
        if flag == 1
            out  = strcat(out, num2str(count));
            flag = 0;
        end
        if i ~= 7
            out = strcat(out, '/');
        end
    end
    out = strcat(out, ' - 0 1');
    
end