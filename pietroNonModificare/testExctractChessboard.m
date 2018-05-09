a=1;
b=5;
images = readImages(a,b);
test= zeros(1, (b-a+1));



for i=1:(b-a+1)

    original = images{i};
    imageTestResize = (resize(original)); % classe di test già sviluppata
    imageTestElaboration = elaborationOne(imageTestResize);
    imageTest = extractChessboardVersion2 (imageTestElaboration);
    

    %mostriamo i risultati 
   % figure, subplot (1,2,1), imshow(original);
         %  subplot (1,2,2), imshow(imageTest);
end