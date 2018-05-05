function out_square = getSquare_alternativo (bw_image, num_candidate, debug, originalImage)

    % get_square try to get all the connected components whose bounding box
    % is squared. It gets the first 'num_candindate' whose convex area is the bigger.

    assert( islogical (bw_image), 'Input image must be logical');
    assert (debug == 1 | debug == 0,...
        'Debug flag must be a true or false value');
    if (debug == 1)
        assert (nargin == 4, '4th parameter required');
    end
    
    squares = [];
    feature_bb = regionprops (bw_image, 'BoundingBox', 'ConvexArea', ...
        'ConvexImage', 'Solidity');

    % Note that the area is the sum of all pixel belonging to the connected
    % component and not the area of the bounding box!

    for i = 1:numel(feature_bb)
        
        width = feature_bb(i).BoundingBox(3);
        height = feature_bb(i).BoundingBox(4);

        current.BoundingBox = feature_bb(i).BoundingBox;
        current.ConvexArea = feature_bb(i).ConvexArea;
        current.ConvexImage = feature_bb(i).ConvexImage;
        current.Solidity = feature_bb(i).Solidity;

        % if the boundingBox is a square (tolerance 20%)
        if abs(width - height) / (height + width) < 0.2
            squares = [squares; current];
        end
    end

    % Sort in descending order by area
    [~, index] = sort ([squares.ConvexArea]);
    index = fliplr (index);
    
    % Select the squares that are the biggest (at least 3/4 of the
    % biggest square)
    requiredArea = round (squares(index (1)).ConvexArea * 0.5);
    biggestSquares = [];
    for i = 1 : numel (squares)
        if squares(i).ConvexArea > requiredArea
            biggestSquares = [biggestSquares; squares(i)];
        end
    end
    
    biggestSquares
    
    [~, indexBySolidity] = sort ([biggestSquares.Solidity])
    indexBySolidity = fliplr (indexBySolidity)
    
    if (debug == 1)
        fh = figure;
        subplot(1, 2, 1)
        imshow(bw_image), title ('Quadrati trovati')
        hold on
%         for i = 1 : numel (index)
        for i = 1 : numel (indexBySolidity)
%             tmp = squares(index(i));
            
            tmp = biggestSquares(indexBySolidity(i));
            startX = tmp.BoundingBox(1);
            startY = tmp.BoundingBox(2);
            finalX = startX + tmp.BoundingBox(3);
            finalY = startY + tmp.BoundingBox(4);

            plot ([startX, finalX, finalX, startX, startX], [startY, startY, finalY, finalY, startY],...
                '-', 'LineWidth', 2); 
        end
        hold off
        subplot(1, 2, 2);
        imshow(originalImage), title ('Immagine originale')
        waitfor(fh);
    end
    
    % get the first x candidates to be possible sudoku containers
%     limit = num_candidate;
%     if num_candidate > numel (index)
%         limit = numel (index);
%     end
    
    limit = num_candidate;
    if num_candidate > numel (indexBySolidity)
        limit = numel (indexBySolidity);
    end

%   index contains the rectangles indexes sorted descedingly by their area.
%   So the rectangles sorted from the bigger to the smaller.
    candidates = [];
    for i = 1 : limit
%         candidates = [candidates; squares(index(i))];
        candidates = [candidates; biggestSquares(indexBySolidity(i))];
    end

    out_square = candidates;
end