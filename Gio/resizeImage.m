function  [resized, ratio]=resizeImage(image)
    %% mio codice
    [r, c, ~] = size(image);
    if r>1000||c>1000
        if r<c
            resized = imresize(image, [1000 NaN]);
            ratio = r/1000;
        else
            resized = imresize(image, [NaN 1000]);
            ratio = c/1000;
        end
    else
    resized = image;
        ratio = 1;
    end
end
    