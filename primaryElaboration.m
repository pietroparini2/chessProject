function out=primaryElaboration (image, testFlag)
    [~, ~, channel] = size(image);
    if channel > 1
     im = rgb2gray (image);
    end
    
    im1= imopen(im, strel('disk',7));
    im2= imclose(im1, strel ('disk', 60));
    edge = imbinarize(im2 - im);
    
    cc = bwconncomp(edge);
    ccSizeThreshold = 2042;
    for i = 1 : cc.NumObjects
      currCC = cc.PixelIdxList{i};
      if size(currCC, 1) < ccSizeThreshold
        edge(currCC) = 0;
      end
    end
     P= testFunction(testFlag,im,im1,im2,edge);
    
    out=edge;
end

%%funzione chiamata per il debug
function out=testFunction(testFlag,im,im1,im2,edge)
    if(testFlag==1)
        figure, subplot(1,4,1), imshow(im), title('image'),
                subplot(1,4,2), imshow(im1), title('imOpen(disk, 7)'),
                subplot(1,4,3), imshow(im2), title('imclose(disk, 60)'),
                subplot(1,4,4), imshow(edge), title('imclose-image')
    end
    out=0;
end