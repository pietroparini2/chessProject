function out_lowpass = bwImage(image, debug)
    [~, ~, ch] = size(image);

    im = image;
    if ch > 1
     im = rgb2gray (image);
    end
    
    imEq = adapthisteq (im);
    
    % cancello le zone nere sottili per poi avere solo quelle come edge
    imedge = imclose (imEq, strel ('disk', 6)) - imEq;
    out_lowpass = imbinarize (imedge, graythresh(imedge));
    
    if (debug == 1)
        figure, subplot(2,2,1), imshow(im), title('Grey'),
                subplot(2,2,2), imshow(imEq), title('imEq'),
                subplot(2,2,3), imshow(imedge), title('imEd'),
                subplot(2,2,4), imshow(out_lowpass), title('BW'),
    end
end