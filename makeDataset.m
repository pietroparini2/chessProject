function chessPieces = makeDataset (n)
    chessPieces = cell(1, 32);
    
    for i = 1 : 32
        %% lettura immagini e piccola elaboraizone
        im = im2double(imread(sprintf('Foto/pezzi/%d.png', i)));
        im = imresize(imadjust(rgb2gray(im)), [n, n]);
        
        %% blurro l'immagine
        chessPieces{i} = imgaussfilt(im, 1);
    end    
end