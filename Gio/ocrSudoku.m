function [stringSudoku, debugValues] = ocrSudoku (image, dataset, ...
    debugEdge, ...
    debugEdgeResult, ...
    debugSquare, ...
    debugRegistration, ...
    debugRegistrationResult, ...
    debugGetCell)

    [h, w, ~] = size(image);
    
    if ~exist('debugEdge', 'var')
        debugEdge = 0;
    end
    
    if ~exist('debugEdgeResult', 'var')
        debugEdgeResult = 0;
    end
    
    if ~exist('debugSquare', 'var')
        debugSquare = 0;
    end
    
    if ~exist('debugRegistration', 'var')
        debugRegistration = 0;
    end
    
    if ~exist('debugRegistrationResult', 'var')
        debugRegistrationResult = 0;
    end
    
    if ~exist('debugGetCell', 'var')
        debugGetCell = 0;
    end
    
    % I will preform the search of the sudoku on the resized image,
    % that will be scaled if the original image is too big, to not
    % slow down the computation
    resized = NaN;
    if h > 1000
        resized = imresize(image, [1000 NaN]); 
    end

    if w > 1000
        resized = imresize(image, [NaN 1000]);
    end

    if ~isnan (resized)
        [hr, ~] = size (resized);
    else
        resized = image;
        hr = 1; % preserves the original ratio.
    end
    
    % I calculate the ratio of the two images, to extract
    % the image of the sudoku from the original image that has an higher
    % resolution
    ratio = h / hr;
    
    cleaned = enhanceSudokuROI (resized, debugEdge);
    squares = getSquare (cleaned, 2, debugSquare, resized);

%    I make the size of the convex image and the sudoku the same.
    sudoku = imcrop (image, (squares(1).BoundingBox(:)) .* ratio);
    convexImage = im2uint8 (squares(1).ConvexImage);
    
    if debugEdgeResult == 1
        fh = figure;
        subplot (1, 2, 1), imshow(sudoku), title ('Sudoku')
        subplot (1, 2, 2), imshow(convexImage), title ('Immagine convessa')
        waitfor (fh);
    end
    
    [hA, wA, ~] = size(sudoku);
    [hB, wB, ~] = size(convexImage);
    % change mask size according to the image size, we will use tha mask later
    if hB ~= hA || wA ~= wB
        convexImage = imresize(convexImage, 'OutputSize', [hA, wA]);
    end
        masked = sudoku - (imcomplement (convexImage));

%   Perform image registration
    convexImage = convexImage > 0; % fit_square_transform accept only logicals
    tform = fitSquareTransform (convexImage, debugRegistration);
    fittedImage = imwarp (masked, tform);
    fittedConvexImage = imwarp (convexImage, tform);

%   Focusing the grid
    stats = regionprops(fittedConvexImage, 'BoundingBox');
    imageFocused = imcrop(fittedImage, stats(1).BoundingBox);
    
    if debugRegistrationResult == 1
        fh = figure;
        subplot (1, 2, 1), imshow(fittedImage), title ('Sudoku registrato')
        subplot (1, 2, 2), imshow(fittedConvexImage), title ('Immagine convessa registrata')
        waitfor (fh);
        
        fh = figure; imshow (imageFocused), waitfor (fh)
    end
    
%   Getting a matrix containing the image of each cell
    cells = getCellsDigits(imageFocused, 16, debugGetCell);
    [stringSudoku, debugValues] = ocrCells (cells, dataset);
end
