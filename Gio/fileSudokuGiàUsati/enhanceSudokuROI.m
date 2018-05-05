function out_lowpass = enhanceSudokuROI (image, debug)

     assert (debug == 1 | debug == 0,...
        'Debug flag must be a true or false value');

    [~, ~, ch] = size(image);

    im = image;
    if ch > 1
     im = rgb2gray (image);
    end
    
    im = adapthisteq (im);
    
    imedge = imclose (im, strel ('disk', 6)) - im;
    out_lowpass = imbinarize (imedge, graythresh(imedge));
    
    if (debug == 1)
        fh = figure;
        imshow(out_lowpass), title('Evidenziazione dei lati')
        waitfor (fh)
    end
    
end