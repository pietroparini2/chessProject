 %% find chessboard 
a=17;
b=17;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = textureElaboration(imageTest);  % classe di test già sviluppata
    
    chessBox   = chessDiscover(imageTest, scale, original);
    straightChess= straightensChess(chessBox.Image,chessBox.ConvexImage);
    
    value= isChessboard(straightChess) ;
end
 
 