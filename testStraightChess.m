%% find chessboard 
a=1;
b=20;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = elaborationOne(imageTest);  % classe di test già sviluppata
    chessBox   = chessDiscover(imageTest, scale, original); % classe di test già sviluppata
    
    straightChess= straightensChess(chessBox.Image,chessBox.ConvexImage);
    
    figure, subplot(1,2,1),imshow(original),
            subplot(1,2,2),imshow(straightChess);
end