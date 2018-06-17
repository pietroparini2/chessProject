function out= secondaryElaboration (image,testFlag)
    
    [~, ~, channel] = size(image);
    if channel > 1
     im = rgb2gray (image);
    end
    
    im = adapthisteq (im);
    close= imclose(im, strel ('disk', 6));
    edge = close - im;
    otsu = graythresh(edge);
    bin = imbinarize (edge, otsu);
    testFunction(testFlag,close,im,edge,bin);
    
    out=bin;
    
end

function out= testFunction(testFlag,close,im,edge,bin)
    if(testFlag==1)
            figure, subplot(1,4,1), imshow (im), title('adapthisteq'), 
                    subplot(1,4,2), imshow (close), title('close'),
                    subplot(1,4,3), imshow (edge), title('close-im'),
                    subplot(1,4,4), imshow (bin), title('otsu binarize');
    end
    out=0;
end