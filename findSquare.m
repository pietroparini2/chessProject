function cells = findSquare(image, debug)
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
                menoY = 2;
            end
            
            if i==8
                piuY = 0;
            else
                piuY = 2;
            end
            
            if j==1
                menoX = 0;
            else
                menoX = 2;
            end
            
            if j==8
                piuX = 0;
            else
                piuX = 2;
            end
            cells{i,j} = image(y-menoY:(y+lato-1+piuY), x-menoX:(x+lato-1+piuX)); 
            cells{i,j} = imresize(cells{i,j}, [50 50]); 
            x = x + lato;
        end
        y = y + lato;
    end
    
    %% debug
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

