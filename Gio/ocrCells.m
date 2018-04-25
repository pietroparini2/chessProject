function [sudokuString, debugResults] = ocrCells (cells, dataset)
% Given the cells, compute, for each angulation (0, 90, 180, 270),
% the recognition function. Store each result into a different
% matrix, one for each angulation.
% 
% Whenever is recognized a digit between 4, 5, and 7 (the digits for which
% the score will be the highest for the correct angulation), increase
% an 'angulation score'.
% 
% Once all the cells are recognized, the correct angulation will be the one
% that has the highest orientation score.
    scoreOrientation = zeros(1, 4);
    matrix0   = zeros (9, 9);
    matrix90  = zeros (9, 9);
    matrix180 = zeros (9, 9);
    matrix270 = zeros (9, 9);
    
    score0   = zeros (9, 9);
    score90  = zeros (9, 9);
    score180 = zeros (9, 9);
    score270 = zeros (9, 9);

    for row = 1 : 1 : 9
        for col = 1 : 1 : 9

            tmpScore = zeros(1, 4);
            tmpDigit = zeros(1, 4);

            if (sum (sum (cells(row, col).Image)) > 1)

                tmpImage = cells(row, col).Image;
                tmp = matchByCorrelation(tmpImage, dataset);
                tmpScore(1) = tmp.Score;
                tmpDigit(1) = tmp.Digit;
                score0(row, col) = tmp.Score;
                matrix0(row, col) = tmp.Digit;

                tmp = matchByCorrelation(imrotate(tmpImage, 90), dataset);
                tmpScore(2) = tmp.Score;
                tmpDigit(2) = tmp.Digit;
                score90(row, col) = tmp.Score;
                matrix90(row, col) = tmp.Digit;

                tmp = matchByCorrelation(imrotate(tmpImage, 180), dataset);
                tmpScore(3) = tmp.Score;
                tmpDigit(3) = tmp.Digit;
                score180(row, col) = tmp.Score;
                matrix180(row, col) = tmp.Digit;

                tmp = matchByCorrelation(imrotate(tmpImage, 270), dataset);
                tmpScore(4) = tmp.Score;
                tmpDigit(4) = tmp.Digit;
                score270(row, col) = tmp.Score;
                matrix270(row, col) = tmp.Digit;

                [~, maxScore] = max (tmpScore(:));
                digit = tmpDigit(maxScore);
                
                if (digit == 4 || digit == 5 || digit == 7)
                    scoreOrientation(maxScore) = scoreOrientation(maxScore) + 1;
                end
            end
        end
    end

    [~, maxOrientation] = max (scoreOrientation);
    finalMatrix = [];
    switch maxOrientation
        case 1
            finalMatrix = matrix0;
            finalScore = score0;
            orientedCells = cells; 
        case 2
            finalMatrix = rot90 (matrix90, 1);
            finalScore = rot90 (score90, 1);
            orientedCells = rot90 (cells, 1); 
        case 3
            finalMatrix = rot90 (matrix180, 2);
            finalScore = rot90 (score180, 2);
            orientedCells = rot90 (cells, 2);
        case 4
            finalMatrix = rot90 (matrix270, 3);
            finalScore = rot90 (score270, 3);
            orientedCells = rot90 (cells, 3);
    end
    
    % Now I search for digits that could potentially be not recognized
    % correctly. We detect them and based on the conflicting digits we
    % select the one that best fit the dicrimination methods.
    
    % I have found during the project that the only conflict appear to be
    % the one involving the 1 and the 4 (usually the 1 appeared like a 4).
    % Other conflicts didn't appear while working with the dataset.
    
    % search for rows and columns whose correlation value is lower
    % than 0.5 
    [r, c] = find (finalScore <= 0.5 & finalScore ~= 0);
    for i = 1 : size (r, 1)
        
        tmp = finalMatrix(r(i), c(i));
        tmpImage = orientedCells(r(i), c(i)).Image;
        switch tmp
            
            case {4, 1}
                
                tmp = padarray (tmpImage, [1, 1], 1);
                
                stat = regionprops (imcomplement (tmp), 'eulernumber');
                
                if stat(1).EulerNumber < 1
                    % HERE MATLAB COMPLAINTS FOR SOMETHING I CANNOT
                    % UNDERSTAND...
                    finalMatrix(r(i), c(i)) = 4;
                else
                    finalMatrix(r(i), c(i)) = 1;
                end
                
                % this notify that a different approach to correlation was
                % used to recognize the digit
                finalScore(r(i), c(i)) = -1;
        end
        
    end
    

    tmpStr = '';
    for i = 1 : 9

        for j = 1 : 9
            if finalMatrix(i, j) == 0
                tmpStr = strcat (tmpStr, '.');
            else
                tmpStr = strcat (tmpStr, int2str (finalMatrix(i, j)));
            end
        end
    end
    
    debugResults = struct();
    debugResults.score = finalScore;
    debugResults.digit = finalMatrix;
    
    sudokuString = tmpStr;
end
