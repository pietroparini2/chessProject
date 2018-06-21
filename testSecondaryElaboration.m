close all, clear, clc;
a=1;
b=1;
images = readImages(a,b);
test= zeros(1, (b-a+1));

for i=1:(b-a+1)
    original = images{i};
    [imageTest, ~] = resizeImage(original); % classe di test già sviluppata
    imageTest = secondaryElaboration (imageTest,1);
    
    figure, subplot (1,2,1), imshow(original);
            subplot (1,2,2), imshow(imageTest);
end