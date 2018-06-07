function [scores, fen] = fenGenerator (cells, dataset) 
    
    % use normxcorr2 to find a template chess in chessboard

    scores = zeros(8, 8, 4);
    indici = zeros(8, 8, 4);

    punteggio = zeros(1, 4);

    %% for per ciclare su tutte le caselle
    for i = 1 : 8
        for j = 1 : 8
            % current cell
            cell = cells{i, j};
            [rows, columns, ~] = size(cell);
            maxCorrValue = -1;
            maxIndex = -1;

            % confronto con tutti i pezzi possibili
            for k = 1: 26
                chess = dataset(k).Image;
                [rows, columns, ~] = size(chess);
                for h = 1 : 4
                    %% template
                    templateWidth = 47;
                    templateHeight = 47;
                    
                    % search for a match.
                    % then take the average of the found locations to get the overall best location.
                    channelToCorrelate = 1;  % Use the red channel.
                    correlationOutput = normxcorr2(chess(:,:,1), cell(:,:, channelToCorrelate));


                    % Find out where the normalized cross correlation image is brightest.
                    [corrValue, index] = max(abs(correlationOutput(:)));
                    if corrValue > maxCorrValue
                        maxCorrValue = corrValue;
                        maxIndex = index;
                        [yPeak, xPeak] = ind2sub(size(correlationOutput),maxIndex(1));
                        % Because cross correlation increases the size of the image, 
                        % we need to shift back to find out where it would be in the original image.
                        corr_offset = [(xPeak-size(chess,2)) (yPeak-size(chess,1))];
                        indici(i, j, h) = k;
                        if k == 1 || k == 26
                            scores(i, j, h) = 0;
                        else
                            scores(i, j, h) = maxCorrValue;
                        end
                        if maxCorrValue < 0.6
                            scores(i, j, h) = 0;
                            indici(i, j, h) = 1;
                        end
                    end
                    chess = rot90(chess);
                end
                
            end
        end
    end

    punteggio(1) = sum(sum(scores(:, :, 1)));  %0
    punteggio(2) = sum(sum(scores(:, :, 2)));  %90
    punteggio(3) = sum(sum(scores(:, :, 3)));  %180
    punteggio(4) = sum(sum(scores(:, :, 4)));  %270

    [m, rotazione] = max(punteggio);
    
    indici = indici(:, :, 1);
    if rotazione > 1
        for i = 1 : rotazione-1
            indici = rot90(indici);
        end
    end
            
    
    %% chiamata per funzione composizione stringa
    fen = fenSting(indici);

















% % use normxcorr2 to find a template chess in chessboard
% 
% scores = zeros(8,8);
% indici = zeros(8,8);
% 
% %% for per ciclare su tutte le caselle
%     %for h = 1 : 4
%         for i = 1 : 8
%             for j = 1 : 8
%                 % current cell
%                 cell = cells{i, j};
%                 [rows, columns, ~] = size(cell);
%                 maxCorrValue = -1;
%                 maxIndex = -1;
% 
%                 % confronto con tutti i pezzi possibili
%                 for k = 1: 26
%                     %% template
%                     chess = dataset(k).Image;
%                     templateWidth = 47;
%                     templateHeight = 47;
%                     % Get the dimensions of the image.
%                     [rows, columns, ~] = size(chess);
% 
% 
%                     % search for a match.
%                     % then take the average of the found locations to get the overall best location.
%                     channelToCorrelate = 1;  % Use the red channel.
%                     correlationOutput = normxcorr2(chess(:,:,1), cell(:,:, channelToCorrelate));
% 
% 
%                     % Find out where the normalized cross correlation image is brightest.
%                     [corrValue, index] = max(abs(correlationOutput(:)));
%                     if corrValue > maxCorrValue
%                         chessX = chess;
%                         maxCorrValue = corrValue;
%                         maxIndex = index;
%                         [yPeak, xPeak] = ind2sub(size(correlationOutput),maxIndex(1));
%                         % Because cross correlation increases the size of the image, 
%                         % we need to shift back to find out where it would be in the original image.
%                         corr_offset = [(xPeak-size(chess,2)) (yPeak-size(chess,1))];
% 
%                         scores(i,j) = maxCorrValue;
%                         indici(i,j) = k;
%                     end      
% 
%                 end
%                 if maxCorrValue < 0.6
%                     chessX = dataset(1).Image;
%                     scores(i,j) = 0.5;
%                     indici(i, j) = 1;
%                 end
%                 
%                 
%                 
%                 
% %                 %% visualizzazione delle immagini DA SPOSTARE POI SOTTO
% %                 [rows, columns, ~] = size(cell);
% %                 figure, subplot(2, 2, 1), imshow(cell);
% %                 axis on; % vedere cosa vuol dire
% %                 caption = sprintf('Original Color Image, %d rows %d colums.', i, j);
% %                 title(caption); % inserendo ('FontSize', fontsize) fontsize = 11; posso ridimensionarlo
% %                 % vedere l'immagine a tutto schermo
% %                 set(gcf, 'units','normalized','outerposition',[0, 0, 1, 1]);
% % 
% %                 % template
% %                 subplot(2, 2, 2);
% %                 imshow(chessX, []);
% %                 axis on;
% %                 caption = sprintf('Template Image to Search For, %d rows by %d columns.', i, j);
% %                 title(caption);
% % 
% %     %             % correlation output
% %     %             subplot(2, 2, 3);
% %     %             imshow(correlationOutput, []);
% %     %             axis on;
% %     %             % Get the dimensions of the image.  numberOfColorBands should be = 1.
% %     %             [rows, columns, numberOfColorBands] = size(correlationOutput);
% %     %             caption = sprintf('Normalized Cross Correlation Output, %d rows by %d columns.', rows, columns);
% %     %             title(caption);
% % 
% %                 % Plot it over the original image.
% %                 subplot(2, 2, 4); % Re-display image in lower right.
% %                 imshow(cell);
% %                 axis on; % Show tick marks giving pixels
% %                 hold on; % Don't allow rectangle to blow away image.
% %                 % Calculate the rectangle for the template box.  Rect = [xLeft, yTop, widthInColumns, heightInRows]
% %                 boxRect = [corr_offset(1) corr_offset(2) templateWidth, templateHeight];
% %                 % Plot the box over the image.
% %                 rectangle('position', boxRect, 'edgecolor', 'g', 'linewidth',2);
% %                 % Give a caption above the image.
% %                 title('Template Image Found in Original Image');
% %                 uiwait(helpdlg('Porzione più simile'));
% %                 close;
%             end
%         end
%     %end
%     
%     %% chiamata per funzione composizione stringa
%     fen = fenSting(indici);
end