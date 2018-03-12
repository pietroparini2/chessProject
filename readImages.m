function images=readImages(x, y)
    for n=x:y
        % lettura immagini
        images{n} = im2double(imread(sprintf('Foto/%03d.jpg',n)));
    end
end