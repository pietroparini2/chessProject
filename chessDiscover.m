function out = chessDiscover(bw_image, scale, original_image, testFlag)
        
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
        
    end
    
    [~, index] = sort ([equalSides.ConvexArea]);
    index = fliplr(index);
    probableChessboard = equalSides(index(1));
    chess = imcrop (original_image, (probableChessboard.BoundingBox(:)) .* scale);
    probableChessboard.Image= chess;
    %chiamata alla funzione di test che verrà applicata solo se testFlag=1
    testFunction(testFlag, bw_image,index, equalSides);

    out = probableChessboard;
end


function out = testFunction(testFlag,bw_image, index, equalSides)
 if (testFlag==1)
        fh = figure;
        subplot(1, 3, 1),
        imshow(bw_image), title ('Immagine pre-elaborata')
        subplot(1, 3, 2),
        imshow(bw_image), title ('Quadrati trovati')
        hold on
       
        for i = 1 : numel (index)
            tmp = equalSides(index(i));
            startX = tmp.BoundingBox(1);
            startY = tmp.BoundingBox(2);
            finalX = startX + tmp.BoundingBox(3);
            finalY = startY + tmp.BoundingBox(4);

            plot ([startX, finalX, finalX, startX, startX], [startY, startY, finalY, finalY, startY],'-', 'LineWidth', 2); 
        end
        
        hold off
        subplot(1, 3, 3),
        imshow(bw_image), title ('Quadrato candidato')
        hold on
       
      
            tmp = equalSides(index(1));
            startX = tmp.BoundingBox(1);
            startY = tmp.BoundingBox(2);
            finalX = startX + tmp.BoundingBox(3);
            finalY = startY + tmp.BoundingBox(4);

            plot ([startX, finalX, finalX, startX, startX], [startY, startY, finalY, finalY, startY],'-', 'LineWidth', 2); 
      
        
        hold off
        waitfor(fh);
 end
 out=0;
end