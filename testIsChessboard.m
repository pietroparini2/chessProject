 %% find chessboard 
a=30;
b=40;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = textureElaboration(imageTest,0);  % classe di test già sviluppata
    
    chessBox   = chessDiscover(imageTest, scale, original,0);
    straightChess= straightensChess(chessBox.Image,chessBox.ConvexImage);
    value= isChessboard(straightChess) ;
    
    figure, imshow(straightChess), title(value);
end
 
 