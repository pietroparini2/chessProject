function chessboardOut = chooseElaboration(imageResized, scale,original)
    
    firstImageTest = mainElaboration(imageResized,0);  
    firstChessBox   = chessDiscover(firstImageTest, scale, original,0); 
    firstStraightChess= straightensChess(firstChessBox.Image,firstChessBox.ConvexImage);
 
    firstEstimateValue = abs(isChessboard(firstStraightChess));

    if(firstEstimateValue > 0.60)
        chessboardOut= firstStraightChess;

    else
        secondImageTest = textureElaboration(imageResized,0);  
        secondChessBox   = chessDiscover(secondImageTest, scale, original,0); 
        secondStraightChess= straightensChess(secondChessBox.Image,secondChessBox.ConvexImage);

        secondEstimateValue = abs(isChessboard(secondStraightChess));

        if(firstEstimateValue > secondEstimateValue)
            chessboardOut= firstStraightChess;
        else
            chessboardOut = secondStraightChess;
        end

    end
        
end

