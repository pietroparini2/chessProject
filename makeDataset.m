function datasetChessPieces = makeDataset (n)
    datasetChessPieces(26) = struct ('Image', zeros(n,n));
    
    for i = 1 : 28
        im = im2double(imread(sprintf('Foto/pezzi/%d.png', i)));
        im = imresize(imadjust(rgb2gray(im)), [n, n]);
        datasetChessPieces(i) = struct('Image', im);
    end
end