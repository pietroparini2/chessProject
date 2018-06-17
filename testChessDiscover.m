close all, clear, clc;
a=1;
b=60;
images = readImages(a,b);
test= zeros(1, (b-a+1));

for i=1:(b-a+1)

    original = images{i};
    [imageTest, scale] = (resizeImage(original));
    %sto provando solo con mainElaboration, textureElaboration escluso
    imageTest = primaryElaboration(imageTest,0);  
    
    chessBox = chessDiscover(imageTest, scale, original, 0);
    figure, subplot(1,2,1),imshow(chessBox.Image),
            subplot(1,2,2),imshow(chessBox.ConvexImage);
end
 
 