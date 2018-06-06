function out=textureElaboration (image)
    [~, ~, channel] = size(image);
    if channel > 1
     im = rgb2gray (image);
    end
    
    im= im2double(im);
   % im = imadjust(im);
   
    im1= imopen(im, strel('disk',7));
    
    edge = imbinarize(imclose(im1, strel ('disk', 60)) - im);
    out=edge;
 
    
    

end
