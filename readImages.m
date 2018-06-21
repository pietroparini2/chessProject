function images = readImages(x, y)
    images = cell(1, y-x+1);
    for n=x:y
        images{n-(x-1)} = im2double(imread(sprintf('./Foto/%03d.jpg',n)));
    end
end