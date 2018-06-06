 %% find chessboard 
a=30;
b=40;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = mainElaboration(imageTest);  % classe di test già sviluppata
    
    chessBox   = chessDiscover(imageTest, scale, original);
    
    figure, subplot(1,2,1),imshow(chessBox.Image),
            subplot(1,2,2),imshow(chessBox.ConvexImage);
end
 
 