function  [imageResized, scale]=resizeImage(image)
    [r, c, ~] = size(image);
    if r>1042||c>1042
        if r<c
            %imresize mantiene le proporzioni
            imageResized = imresize(image, [1042 NaN]);
            scale = r/1042;
        else
            imageResized = imresize(image, [NaN 1042]);
            scale = c/1042;
        end
    else
    imageResized = image;
    scale = 1;
    end
end
    