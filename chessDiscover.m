function out = chessDiscover(bw_image, scale, original_image)
        
    equalSides = [];
    errorAprox=0.20;
    
    
    infoBox = regionprops(bw_image, 'BoundingBox', 'ConvexArea', 'ConvexImage');
    
    for i = 1:numel(infoBox)
        width = infoBox(i).BoundingBox(3);
        height = infoBox(i).BoundingBox(4);
        
        current.BoundingBox = infoBox(i).BoundingBox;
        current.ConvexArea = infoBox(i).ConvexArea;
        current.ConvexImage = infoBox(i).ConvexImage;
       
        if abs(width - height) / (height + width) < errorAprox
            equalSides = [equalSides; current];
        end
        
        % da aggiungere il filtro con le diagonali = per filtrare ancora
        % equalsSides
    end
    
    [~, index] = sort ([equalSides.ConvexArea]);
    index = fliplr(index); % lo rovescio
    
    probableChessboard = equalSides(index(1));
    
    
    chess = imcrop (original_image, (probableChessboard.BoundingBox(:)) .* scale);
    probableChessboard.Image= chess;

    out = probableChessboard;
end