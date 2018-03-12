%%funzione con un po' di prove di preelaborazione a caso 
%%interessante il pezzo in cui vengono tolte le componenti connesse sotto ad
%un valore fissato di pixel

function output=elaborazione2(x, y, images)
    h = [-1, -2, -1; 
      0,  0,  0;
      1,  2 , 1 ];
s= strel('square', 10);
s1= strel('square',20);



%ciclo per iterare le prove sulle prime n immagini
for(pippo=x:y)
    imageOriginal{pippo}=rgb2gray(im2double(imread(sprintf('Foto/%03d.jpg',pippo))));
    images{pippo}=sauvola(imageOriginal{pippo},[25 25]);
     images{pippo}=1-images{pippo};
     
     %image{pippo}=imopen(image{pippo},s1);
     images{pippo}=imdilate(images{pippo},s);
     images{pippo}=imclose(images{pippo},s1);
     
     
    cc = bwconncomp(images{pippo});
    ccSizeThreshold = 100000;%parametro fissato a caso
    for i = 1 : cc.NumObjects
      currCC = cc.PixelIdxList{i};
      if size(currCC, 1) < ccSizeThreshold
        images{pippo}(currCC) = 0;
      end
    end
    
    output= images;

end