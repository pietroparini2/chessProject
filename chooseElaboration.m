function chessboardOut = chooseElaboration(imageResized, scale,original)
    
    firstImageTest = mainElaboration(imageResized,0);  
    firstChessBox   = chessDiscover(firstImageTest, scale, original); 
    firstStraightChess= straightensChess(firstChessBox.Image,firstChessBox.ConvexImage);
 
    firstEstimateValue = abs(isChessboard(firstStraightChess));

    if(firstEstimateValue > 0.60)
        chessboardOut= firstStraightChess;

    else
        secondImageTest = textureElaboration(imageResized);  
        secondChessBox   = chessDiscover(secondImageTest, scale, original); 
        secondStraightChess= straightensChess(secondChessBox.Image,secondChessBox.ConvexImage);

        secondEstimateValue = abs(isChessboard(secondStraightChess));

        if(firstEstimateValue > secondEstimateValue)
            chessboardOut= firstStraightChess;
        else
            chessboardOut = secondStraightChess;
        end

    end
        
end

