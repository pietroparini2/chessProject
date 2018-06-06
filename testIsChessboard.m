 %% find chessboard 
a=1;
b=10;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = mainElaboration(imageTest);  % classe di test già sviluppata
    
    chessBox   = chessDiscover(imageTest, scale, original);
    
    value= isChessboard(chessBox.Image);
end
 
 