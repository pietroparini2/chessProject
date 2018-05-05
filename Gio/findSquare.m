function cells = findSquare(image, numSections, debug)
    % mio codice
    [m, n, ~] = size(image);
    lato = m/8;
    cells = cell(8,8);
    y = 1;
    for i=1:8
        x = 1;
        for j=1:8
            if i==1
                menoY = 0;
            else
                menoY = 10;
            end
            
            if i==8
                piuY = 0;
            else
                piuY = 11;
            end
            
            if j==1
                menoX = 0;
            else
                menoX=10;
            end
            
            if j==8
                piuX = 0;
            else
                piuX = 11;
            end
            
            cells{i,j} = image(y-menoY:(y+lato-1+piuY), x-menoX:(x+lato-1+piuX));
            x = x + lato;
        end
        y = y + lato;
    end
    
    if debug == 1
        for i = 1:1:8
            for j = 1:1:8
                h = figure;
                imshow(cells{i, j}); title(sprintf('C: %d, %d', i, j));
                waitfor(h);
            end
        end
    end
end

