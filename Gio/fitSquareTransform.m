function out_transform = fitSquareTransform (convexImage, showIntermediate)
    assert (islogical (convexImage), 'Input image must be of type logical');
    assert (showIntermediate == 1 | showIntermediate == 0,...
        'Intermediate result flag must be a true or false value');

    [~, num_shape] = bwlabel (convexImage);

    assert (num_shape == 1, ['Input image must contain just the polygonal '...
        'shape with 4 vertices']);

    %   create some gap between polygon border and the image edges
    %   to enhance corner detection.
    padded = padarray(convexImage, [10, 10]);

    % TODO: try to grasp more of this math magic...
    % "Just" mathematical magic done in matlab.
    % 'It finds where the sums and differences of
    % the coordinates in the shape are maximized and minimized.'
    %
    % constraint: the edges of the square must be roughly alinged
    % with the edges (tested to work until ~40 degree).
    %
    % found at:
    % it.mathworks.com/matlabcentral/answers/130851-how-to-find-rectangular-corners

    % find rows and columns where padded is 1
    [I,J] = find (padded > max (padded(:)) / 2);
    
    % distribute rows and columns into 2d matrix 
    IJ = [I, J];
    
    % finds where the sums and differences of
    % the coordinates in the shape are maximized and minimized
    [~, idx] = min (IJ * [1 1; 1 -1; -1 1; -1 -1].');
    % IJ * [1, 1] give the topmost/leftmost coordinates
    % IJ * [1, -1] give the topmost/rightmost coordinates
    % IJ * [-1, 1] give the bottomost/leftmost coordinates
    % IJ * [-1, -1] give the bottomost/rightmost coordinates
    % get the minimum of each group of result and get the position where it
    % finds the minimum
    % (that's why I get the second argument from the result of min)
    % find the corresponding coordinates from IJ (that contains the
    % coordinates)
    corners = IJ(idx, :);
    
    % Now I separate each detected corner and create an homography matrix
    % to shear the image to get a perspective correction.
    % I estimate the homographic transformation by calculate
    % the desidered corner where the new polygon will be placed (a perfect
    % square).
    %
    % I adjust the offset to match the mid of the distance between the
    % perfect corner of the square and the actual position of the corners
    % in the polygon.

    top_left  = corners (1, :);
    top_right = corners (2, :);
    bot_left  = corners (3, :);
    bot_right = corners (4, :);

    % m is for "most at", it's the "most at" sx, top, bottom and dx edges.
    msx  = min ( min (corners(:, 2)));
    mdx  = max ( max (corners(:, 2)));
    mtop = min ( min (corners(:, 1)));
    mbot = max ( max (corners(:, 1)));

    % here I calculate the offset, so the difference from 2 point
    % computed relative to one axis (x-axis for sx and dx; y-axis for top and
    % bot)

    top_offset = abs (top_left(1) - top_right(1)) - mtop;
    bot_offset = abs (bot_left(1) - bot_right(1));
    left_offset = abs (top_left(2) - bot_left(2)) - msx;
    right_offset = abs (top_right(2) - bot_right(2));

    fixed = [
        mtop + top_offset / 2, msx + left_offset / 2;
        mtop + top_offset / 2, mdx - right_offset / 2;
        mbot - bot_offset / 2, msx + left_offset / 2;
        mbot - bot_offset / 2, mdx - right_offset / 2

        ];

    if showIntermediate
        fh = figure;
        imshow(padded);

        hold on
        plot(corners(:, 2), corners(:, 1), 's');
        plot(fixed(:, 2), fixed(:, 1), 's');
        legend ('Detected Corners', 'Ideal destination Corners',...
            'Location', 'bestoutside');
        hold off
        
        waitfor (fh)

    end
    
    % fitgeotrans expected points to be X AND THEN Y, while
    % I usually have Y AND THEN X [2 MONTHS GONE FOR THIS!!!]
    tmpPoint = [corners(:, 2) corners(:, 1)];
    tmpPointFixed = [fixed(:, 2) fixed(:, 1)];
    out_transform = fitgeotrans (tmpPoint, tmpPointFixed , 'projective');
    
end