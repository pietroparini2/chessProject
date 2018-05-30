function datasetChessPieces = makeChessPiecesDataset (n)
    datasetChessPieces(9) = struct ('Image', zeros(n,n));
    
    for i = 1 : 12
        im = im2double(imread(sprintf('pezziScacchi/%d.png', i)));
        im = imbinarize(rgb2gray(im));
        stats = regionprops(~im, 'Image'); %non so a cosa serva
        boh = imresize (im2double ((stats(1).Image) == 0), ...
            'Output', [n, n]);
        boh = imbinarize(boh);
        datasetChessPieces(i) = struct('Image', boh);
    end
end