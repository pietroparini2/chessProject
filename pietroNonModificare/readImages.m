function images=readImages(x, y)
    for n=x:y
        %% lettura immagini originali
        images{n-(x-1)} = im2double(imread(sprintf('immaginiScacchi/%03d.jpg',n)));
    end
end