function out = chessDiscover(bwImage, scale, original_image, testFlag)
        
    equalSides = [];
    errorAprox=0.18;
    infoBox = regionprops(bwImage, 'BoundingBox', 'ConvexArea', 'ConvexImage');
    
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
    testFunction(testFlag, bwImage,index, equalSides);

    out = probableChessboard;
end


function out = testFunction(testFlag,bwImage, index, equalSides)
 if (testFlag==1)
        output = figure;
        subplot(1, 3, 1),
        imshow(bwImage), title ('Immagine pre-elaborata')
        subplot(1, 3, 2),
        imshow(bwImage), title ('Quadrati trovati')
        hold on
       
        for i = 1 : numel(index)
            temp = equalSides(index(i));
            up = temp.BoundingBox(1);
            left = temp.BoundingBox(2);
            bottom = up + temp.BoundingBox(3);
            right = left + temp.BoundingBox(4);

            plot ([up, bottom, bottom, up, up], [left, left, right, right, left],'-', 'LineWidth', 2); 
        end
        
        hold off
        subplot(1, 3, 3),
        imshow(bwImage), title ('Quadrato candidato')
        hold on
       
      
            temp = equalSides(index(1));
            up = temp.BoundingBox(1);
            left = temp.BoundingBox(2);
            bottom = up + temp.BoundingBox(3);
            right = left + temp.BoundingBox(4);

            plot ([up, bottom, bottom, up, up], [left, left, right, right, left],'-', 'LineWidth', 2); 
      
        
        hold off
        waitfor(output);
 end
 out=0;
end