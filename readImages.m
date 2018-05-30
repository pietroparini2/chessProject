function images = readImages(x, y)
    for n=x:y
        images{n-(x-1)} = im2double(imread(sprintf('./Foto/%03d.jpg',n)));
    end
end