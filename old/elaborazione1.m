function output=elaborazione1(x, y, images)
    se = strel('disk', 5);
    for n = x:y
        imagesGray{n} =  rgb2gray(images{n});    
        I{n} = imagesGray{n};
        I{n} = im2double(imbinarize(imopen(I{n}, se)));
        I{n} = imbinarize(imgaussfilt(im2double(I{n}), 10));
    end
    output = I;
end