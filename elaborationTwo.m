function out=elaborationTwo (image)

    
    image = rgb2gray(image);
    image = im2double(image);

    out = imadjust(image);

end
