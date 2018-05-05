function out_lowpass = enhanceSudokuROI_alternativo (image, debug)

     assert (debug == 1 | debug == 0,...
        'Debug flag must be a true or false value');

    [~, ~, ch] = size(image);

    tmp = image;
    if ch > 1
     tmp = rgb2gray (image);
    end
    
    
    equalized = adapthisteq (tmp);
    
    structural = zeros (3, 3);
    structural (2, :) = 1;
    structural (:, 2) = 1;
    
    str1 = [ 1 1 1; 1 0 0; 1 0 0]
    str2 = rot90 (str1, 1)
    str3 = rot90 (str1, 2)
    str4 = rot90 (str1, 3)
    
    imedge = imdilate (edge (equalized, 'sobel'), ...
       strel ('arbitrary', structural));
    
    imedge1 = imdilate (edge (equalized, 'sobel'), ...
        strel ('arbitrary', str1));
    
    imedge2 = imdilate (edge (equalized, 'sobel'), ...
        strel ('arbitrary', str2));
    
    imedge3 = imdilate (edge (equalized, 'sobel'), ...
        strel ('arbitrary', str3));

    imedge4 = imdilate (edge (equalized, 'sobel'), ...
        strel ('arbitrary', str4));
    
    %out_lowpass = imbinarize (imedge, graythresh(imedge));
    out_lowpass = imsharpen (equalized) - equalized;
    
    if (debug == 1)
        fh = figure;
        imshow(out_lowpass), title('Evidenziazione dei lati')
        waitfor (fh)
    end
    
end