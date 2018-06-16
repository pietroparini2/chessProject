function out= mainElaboration (image,testFlag)
    %se ha più canali la concerto in gray scale
    [~, ~, channel] = size(image);
    if channel > 1
     im = rgb2gray (image);
    end
    
    %Equalizzazione adattiva dell'istogramma adattato al contrasto (CLAHE)
    %https://it.mathworks.com/help/images/ref/adapthisteq.html
    im = adapthisteq (im);
    
    %sottrazione chiusura con immagine a livelli di grigi
    close= imclose(im, strel ('disk', 6));
    edge = close - im;
    
    %Global image threshold using Otsu's method
    otsu = graythresh(edge);
    
    %binarizzazione immagine  usando la soglia otsu
    bin = imbinarize (edge, otsu);

    
    if(testFlag==1)
        figure, subplot(1,4,1), imshow (im), title('adapthisteq'), 
                subplot(1,4,2), imshow (close), title('close'),
                subplot(1,4,3), imshow (edge), title('close-im'),
                subplot(1,4,4), imshow (bin), title('otsu binarize');
                
    end
    
    out=bin;
    
end