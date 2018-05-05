function imageFocused = shearBoard(chess, convexImage, debugShearChess)
    [hA, wA, ~] = size(chess);
    [hB, wB, ~] = size(convexImage);
    % change mask size according to the image size, we will use tha mask later
    if hB ~= hA || wA ~= wB
        convexImage = imresize(convexImage, 'OutputSize', [hA, wA]);
    end
        masked = im2uint8(chess) - (imcomplement (convexImage));

    % Perform image registration
    convexImage = convexImage > 0; % fit_square_transform accept only logicals
    tform = fitSquareTransform (convexImage, debugShearChess); %funzione ancora non riguardata
    fittedImage = imwarp (masked, tform);
    fittedConvexImage = imwarp (convexImage, tform);
    
    % Focusing the grid
    stats = regionprops(fittedConvexImage, 'BoundingBox');
    imageFocused = imcrop(fittedImage, stats(1).BoundingBox);
    
    if debugShearChess == 1 
        figure, imshow(imageFocused), title('scacchiera raddrizzata');
    end
end