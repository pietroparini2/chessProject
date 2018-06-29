close all, clear, clc;
a=3;
b=3;
images = readImages(a,b);
test= zeros(1, (b-a+1));

for i=1:(b-a+1)

    original = images{i};
    [imageTest, ~] = resizeImage(original); % classe di test già sviluppata
    imageTest = primaryElaboration(imageTest,1);
    
    %mostriamo i risultati
    figure, subplot (1,2,1), imshow(original);
            subplot (1,2,2), imshow(imageTest);
end