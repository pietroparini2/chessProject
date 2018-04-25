function out_square = getSquare (bw_image, num_candidate, debug, originalImage)

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
        'ConvexImage');

    % Note that the area is the sum of all pixel belonging to the connected
    % component and not the area of the bounding box!

    for i = 1:numel(feature_bb)
        
        width = feature_bb(i).BoundingBox(3);
        height = feature_bb(i).BoundingBox(4);

        current.BoundingBox = feature_bb(i).BoundingBox;
        current.ConvexArea = feature_bb(i).ConvexArea;
        current.ConvexImage = feature_bb(i).ConvexImage;
       
        % if the boundingBox is a square (tolerance 20%).
        % Computed as the ratio between the difference from the edges and
        % the sum of the two.
        % Some examples
        % w = 1, h = 500: |(500 - 1)| / (500 + 1) = 99,6
        % w = 50, h = 50: |(50 - 50)| / ... = 0 perfect square
        if abs(width - height) / (height + width) < 0.20
            squares = [squares; current];
        end
    end

    % Sort in descending order by area
    [~, index] = sort ([squares.ConvexArea]);
    index = fliplr (index);
    
    if (debug == 1)
        fh = figure;
        subplot(1, 2, 1)
        imshow(bw_image), title ('Quadrati trovati')
        hold on
        for i = 1 : numel (index)
            tmp = squares(index(i));
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
    limit = num_candidate;
    if num_candidate > numel (index)
        limit = numel (index);
    end

%   index contains the rectangles indexes sorted descedingly by their area.
%   So the rectangles sorted from the bigger to the smaller.
    candidates = [];
    for i = 1 : limit
        candidates = [candidates; squares(index(i))];
    end

    out_square = candidates;
end