clear all ;
close all ;

h = [-1, -2, -1; 
      0,  0,  0;
      1,  2 , 1 ];
s= strel('square', 10);
s1= strel('square',20);



%ciclo per iterare le prove sulle prime n immagini
for(pippo=1:5)
    imageOriginal{pippo}=rgb2gray(im2double(imread(sprintf('Foto/%03d.jpg',pippo))));
    image{pippo}=sauvola(imageOriginal{pippo},[50 50]);
     image{pippo}=1-image{pippo};
     
     %image{pippo}=imopen(image{pippo},s1);
     image{pippo}=imdilate(image{pippo},s);
     image{pippo}=imclose(image{pippo},s1);
     
     
    cc = bwconncomp(image{pippo});
    ccSizeThreshold = 100000;
    for i = 1 : cc.NumObjects
      currCC = cc.PixelIdxList{i};
      if size(currCC, 1) < ccSizeThreshold
        image{pippo}(currCC) = 0;
      end
    end
    
     
    labels{pippo} = bwlabel(image{pippo});
    out{pippo}=funzioneDetectBoard(image{pippo});
    
    lines = out{pippo};
    
   
    figure, 
            subplot(1,3,1),imshow(imageOriginal{pippo});
            subplot(1,3,2), imshow(image{pippo}); hold on; n = size(I,2);
                            for k = 1:length(lines)
                                % Overlay kth line
                                x = [lines(k).point1(1) lines(k).point2(1)];
                                y = [lines(k).point1(2) lines(k).point2(2)];
                                line = @(z) ((y(2) - y(1)) / (x(2) - x(1))) * (z - x(1)) + y(1);
                                plot([1 n],line([1 n]),'Color','r');
                            end
            subplot(1,3,3), imagesc(labels{pippo}),axis image,colorbar;
end











