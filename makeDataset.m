function [chessPieces, chessPiecesB ] = makeDataset (n)
    chessPieces = cell(1, 32);
    chessPiecesB = cell(1, 32);
    
    for i = 1 : 32
        im = im2double(imread(sprintf('Foto/pezzi/%d.png', i)));
        im = imresize(imadjust(rgb2gray(im)), [n, n]);
        chessPieces{i} = im;
        
        %% immagine blurrata
        chessPiecesB{i} = imgaussfilt(im, 1);
    end

%     % percreare struttura dataset 
%     datasetChessPieces(32) = struct ('Image', zeros(n,n));
%     
%     for i = 1 : 32
%         im = im2double(imread(sprintf('Foto/pezzi/%d.png', i)));
%         im = imresize(imadjust(rgb2gray(im)), [n, n]);
%         datasetChessPieces(i) = struct('Image', im);
%     end


    
end