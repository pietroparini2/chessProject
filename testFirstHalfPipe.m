close all, clear, clc;
a=30;
b=60;

images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); 
    imageTest = chooseElaboration(imageResized,scale,original);  
    figure, subplot(1,2,1), imshow(original),
            subplot(1,2,2), imshow(imageTest),
            
end