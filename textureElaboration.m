function out=textureElaboration (image, testFlag)
    [~, ~, channel] = size(image);
    if channel > 1
     im = rgb2gray (image);
    end
    
    im= im2double(im);
   % im = imadjust(im);
   
    im1= imopen(im, strel('disk',7));
    im2= imclose(im1, strel ('disk', 60));
    
    edge = imbinarize(im2 - im);
    
    if(testFlag==1)
        figure, subplot(1,4,1), imshow(im), title('im2Double'),
                subplot(1,4,2), imshow(im1), title('imOpen(disk, 7)'),
                subplot(1,4,3), imshow(im2), title('imclose(disk, 60)'),
                subplot(1,4,4), imshow(edge), title('imclose-image')
    end
    
    out=edge;
 
    
    

end
