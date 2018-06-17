function [chessboardOut,choose] = chooseElaboration(imageResized, scale,original)
    firstImageTest = primaryElaboration(imageResized,0);  
    firstChessBox   = chessDiscover(firstImageTest, scale, original,0); 
    firstStraightChess= straightensChess(firstChessBox.Image,firstChessBox.ConvexImage);
 
    firstEstimateValue = abs(isChessboard(firstStraightChess));

    if(firstEstimateValue > 0.50)
        chessboardOut=firstStraightChess;
        choose=1;
        
    else
        secondImageTest = secondaryElaboration(imageResized,0);  
        secondChessBox   = chessDiscover(secondImageTest, scale, original,0); 
        secondStraightChess= straightensChess(secondChessBox.Image,secondChessBox.ConvexImage);

        secondEstimateValue = abs(isChessboard(secondStraightChess));

        if(firstEstimateValue > secondEstimateValue)
            chessboardOut= firstStraightChess;
            choose=1;
        else
            chessboardOut = secondStraightChess;
            choose=2;
        end

    end
        
end

