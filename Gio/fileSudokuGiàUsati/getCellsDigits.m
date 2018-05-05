function cells = getCellsDigits(image, numSections, debug)
% Given a grayscale image extracts the image of the digit from every cell
% (if present).

% Given the RGB image, get the value of a single cell (dividing height and
% width by 9). Go throught the image using a sliding window with one and an half
% the dimension of a single cell (to get at least a single cell even from distorted
% images).
% 
% Makes the labelling and takes only the label that approximatly are larger than
% 10% and smaller than 50% of the window (this prevents getting the grid and
% some noise).
% 
% From each label, computes its distance from the center of the window (the
% digit if present should be the nearest label from the center).
% 
% Sort the labels by their distances and get the nearest to the center.
% If the nearest is distant from the center by more than the 30% of the window
% it means that the cell is empty and that label is a digit from an adjacent
% cell.
%
% Got the digit label, sample it and store it for further computations.

   assert (debug == 1 | debug == 0,...
        'Debug flag must be a true or false value');
    [rows, columns, ~] = size (image);
    cell_height = round (rows / 9);
    cell_width = round (columns / 9);
    
    mid_cell_y = round (cell_height / 2);
    mid_cell_x = round (cell_width / 2);

    cells = [];
    y = mid_cell_y;
    for row = 1 : 1 : 9

        top = round (y - mid_cell_y * 1.5);
        if (top < 1)
            top = 1;
        end

        bottom = round (y + mid_cell_y * 1.5);
        if (bottom > rows)
            bottom = rows;
        end

        x = mid_cell_x;
        for col = 1 : 1 : 9

            left = round (x - mid_cell_x * 1.5);
            if (left < 1)
                left = 1;
            end

            right = round (x + mid_cell_x * 1.5);
            if (right > columns)
                right = columns;
            end

            % getting a cell and a half window
            window = image(top : bottom, left : right, :);
            
            % needed to get the label nearest to the center
            [h, w, ~] = size (window);
            midw_h = round (h / 2);
            midw_w = round (w / 2);
            
            % get a perfect single cell to avoid gettin the black border
            % on the outer cells of the sudoku that could influence the
            % computation of otsu threshold
            restrictedWindow = window (...
                round (h * 0.1) : round (h * 0.9),...
                round (w * 0.1) : round (w * 0.9),...
                :...
            );
                                    
            window = im2double(window);
            window = rgb2gray (window);
            window = imbinarize(window, graythresh(restrictedWindow));
            stats = regionprops( ~window, 'BoundingBox', 'Image');
            digit_candidates = [];
            for i = 1 : numel(stats)

                w_width = stats(i).BoundingBox(3);
                w_height = stats(i).BoundingBox(4);
                
                % the digit will be greater than the 10% of the window
                % and smaller than the 50% of it
                if w_width < w * 0.5 && w_width > w * 0.1...
                    && w_height < h * 0.5 && w_height > h * 0.1
                   digit_candidates = [digit_candidates i];
                end

            end
            
%           contains coordinates of the center of the
%           boundingbox of the image
            centerPoints = ones (numel (digit_candidates, 2));
            for candidate = 1 : numel (digit_candidates)
                centerPoints(candidate, 2) = ...
                    stats(digit_candidates(candidate)).BoundingBox(1) +...
                    round (stats(digit_candidates(candidate)).BoundingBox(3) / 2);
                centerPoints(candidate, 1) = ...
                    stats(digit_candidates(candidate)).BoundingBox(2) +...
                    round (stats(digit_candidates(candidate)).BoundingBox(4) / 2);
            end
            
            % Initialization value
            cells(row, col).Image = 0;
            if (numel (digit_candidates) > 0)
                
%               I want to implement the eclidean distance, so I
%               have replicated the center coordinates to subtract it to the
%               center of the labels we have found.
                replicated_mid_point = repmat([midw_h midw_w]', 1,...
                    numel(digit_candidates));
%               D_ab = sqrt ( (b_x-a_x)^2 + (b_y-a_y)^2)
                distances = sqrt (sum ((centerPoints' - replicated_mid_point) .^ 2));
                [min_distance, candidate] = min (distances);

                if (min_distance < 0.20 * h || min_distance < 0.20 * w)

                    vect = imresize (stats(digit_candidates(candidate)).Image,...
                        'Output', [numSections, numSections]);
                    
                    cells(row, col).Image = ~vect;
                end
            end
            
            if (debug == 1)
                fh = figure;
                subplot(1, 2, 1);
                % if the image is not completely white (no digit found)
                if sum (sum (cells(row, col).Image)) > 0
                    imshow(cells(row, col).Image);
                else
                    imshow( ones (numSections, numSections));
                end
                title ('Digit trovato')
                subplot(1, 2, 2);
                imshow(window);
                title(sprintf('Cell %d, %d', row, col));
                hold on;
                plot(midw_w, midw_h, 's');
                hold off;
                waitfor(fh);
            end
            
            
            x = x + cell_width;
        end

        y = y + cell_height;
    end
    
    cells;
end

