%% find chessboard 
a=01;
b=01;

images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)
% % %  vecchio test che stampa le due strade prese con le due elaborazioni
%     original = images{i};
%     [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
%     imageTest = mainElaboration(imageResized);  % classe di test già sviluppata
%     chessBox   = chessDiscover(imageTest, scale, original); % classe di test già sviluppata
%     straightChess= straightensChess(chessBox.Image,chessBox.ConvexImage);
%     
%     imageTestBis = textureElaboration(imageResized);  % classe di test già sviluppata
%     chessBoxBis   = chessDiscover(imageTestBis, scale, original); % classe di test già sviluppata
%     straightChessBis = straightensChess(chessBoxBis.Image,chessBoxBis.ConvexImage);
%     
%     figure, subplot(2,4,1), imshow(original),
%             subplot(2,4,2), imshow(imageTest),
%             subplot(2,4,3), imshow(chessBox.Image),
%             subplot(2,4,4), imshow(straightChess),
%             subplot(2,4,5), imshow(original),
%             subplot(2,4,6), imshow(imageTestBis),
%             subplot(2,4,7), imshow (chessBoxBis.Image),
%             subplot(2,4,8), imshow (straightChessBis),

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = chooseElaboration(imageResized,scale,original);  % classe di test già sviluppata
    
    
    figure, subplot(1,2,1), imshow(original),
            subplot(1,2,2), imshow(imageTest),
            


end