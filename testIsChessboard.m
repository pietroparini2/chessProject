close all, clear, clc;
a=1;
b=1;
images = readImages(a,b);
value= zeros(1, (b-a+1));

for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original));
    %testata con primaryElaboration
    imageTest = primaryElaboration(imageTest,0); 
    %imageTest = secondaryElaboration(imageTest,0);
    chessBox = chessDiscover(imageTest, scale, original,0);
    straightChess= straightensChess(chessBox.Image,chessBox.ConvexImage);
    value(i)= isChessboard(straightChess) ;
    figure, imshow(straightChess), title(value);
end
 
 