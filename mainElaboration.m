function out= mainElaboration (image)
    %se ha più canali la concerto in gray scale
    [~, ~, channel] = size(image);
    if channel > 1
     im = rgb2gray (image);
    end
    
    %Equalizzazione adattiva dell'istogramma adattato al contrasto (CLAHE)
    %https://it.mathworks.com/help/images/ref/adapthisteq.html
    im = adapthisteq (im);
    
    %sottrazione chiusura con immagine a livelli di grigi
    edge = imclose(im, strel ('disk', 6)) - im;
    
    %Global image threshold using Otsu's method
    otsu = graythresh(edge);
    
    %binarizzazione immagine  usando la soglia otsu
    out = imbinarize (edge, otsu);
    
end