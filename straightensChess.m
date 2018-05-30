function out  = straightensChess (image, mask)
    [r, c, ~] = size(mask);
    image = imresize(image, [r, c]);
  
    Corners = cornersMask(mask);
    
    left = mean(Corners([1 4],1));
    right = mean(Corners([2 3],1));
    top = mean(Corners([1 2],2));
    bottom = mean(Corners([3 4],2));
    newCorners = [left top; right top; right bottom; left bottom];
    
    transformation = fitgeotrans(Corners ,newCorners,'projective');
    tranformMask = imwarp(mask,transformation); 
    transformImage = imwarp(image,transformation);

    chessBoard = regionprops(tranformMask, 'boundingBox');
    
   
    out = imcrop (transformImage, (chessBoard(1).BoundingBox(:)));
end