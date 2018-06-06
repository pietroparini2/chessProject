%% classe di test per la funzione elaborationOne

a=1;
b=20;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    [imageTest, ~] = resizeImage(original); % classe di test già sviluppata
    imageTest = elaborationOne (imageTest);
    
    %mostriamo i risultati(peri risultati intermedi bisogna aggiungere un valore di debug)
    figure, subplot (1,2,1), imshow(original);
            subplot (1,2,2), imshow(imageTest);
end