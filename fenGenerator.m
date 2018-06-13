function [fen, angle] = fenGenerator (chessboard, dataset) 
    
    %% chiamata al metodo per estrarre le celle
    cells = findSquare(chessboard, 0);

    scores = zeros(8, 8, 4);
    indici = zeros(8, 8, 4);
    
    %% ricerca re
    for i = 1 : 8
        for j = 1 : 8
            cella = cells{i,j};
            king1 = dataset(1).Image;
            king2 = dataset(1).Image;
            for k = 1 : 4
                corrOut1 =  normxcorr2(king1, cella); % ricerca del tamplate
                corrOut2 =  normxcorr2(king2, cella); % ricerca del tamplate
                corrValue = max(max(abs(corrOut1(:))), max(abs(corrOut2(:))));
                
                scores(i, j, k) = corrValue;
                king1 = rot90(king1);
                king2 = rot90(king2);
            end
        end
    end
    
    correct = 0;
    maximum = 0;
    for h = 1 : 4
        
        scoresApp = scores(:,:, h);
        maxApp = max(max(scoresApp));
        if maximum < maxApp 
            maximum = maxApp;
            correct = h;
        end
        [x,y] = find(scoresApp==maximum);
        indici(x, y, h) = 1;
    end
    
    indici = indici(:, :, correct);
    
    cellW = 0;
    if correct == 1 || correct == 2
        cellW = 1;
    end
    
    maxScores = zeros(8, 8);
    %% riconoscimento altri pezzi
    for i = 1 : 8
        for j = 1 : 8
            cella = cells{i, j}; % cella corrente
            maxCorrValue = zeros(1, 4);
            for k = 3 : 28 % confronto con tutti i pezzi possibili
                % se la prima cella è bianca non devo farlo se l
                if ~(mod(i+j, 2)==0 & cellW == 1 & mod(k, 2)==1) | ~(mod(i+j, 2)==0 & cellW == 0 & mod(k, 2)==0)
                    chess = dataset(k).Image; %template corrente

                    if correct ~= 1
                        for h = 1 : (correct-1)
                            chess = rot90(chess);
                        end
                    end
                    if indici(i, j) ~= 1
                        correlationOutput = normxcorr2(chess, cella); % ricerca del tamplate
                        % Find out where the normalized cross correlation image is brightest.
                        corrValue = max(abs(correlationOutput(:)));
                        if corrValue > maxCorrValue
                            maxCorrValue = corrValue;
                               % Because cross correlation increases the size of the image, 
                            % we need to shift back to find out where it would be in the original image.
                            indici(i, j) = k;
                            maxScores(i, j) = maxCorrValue;
                            if k == 25 || k == 26 || k == 27 || k == 28 
                                maxScores(i, j) = 0;
                            else
                                maxScores(i, j) = maxCorrValue;
                            end
    %                         if maxCorrValue < 0.58
    %                             maxScores(i, j) = 0;
    %                             indici(i,j) = 25;
    %                         end
                        end
                    end
                end
            end
        end
    end
    
    angle = 0;
    if correct ~= 1
        angle = -90 * (correct-1);
        indici = imrotate(indici, angle);
    end

%     punteggio(1) = sum(sum(scores(:, :, 1)));  %0
%     punteggio(2) = sum(sum(scores(:, :, 2)));  %90
%     punteggio(3) = sum(sum(scores(:, :, 3)));  %180
%     punteggio(4) = sum(sum(scores(:, :, 4)));  %270
% 
%     [m, rotazione] = max(punteggio);
%     
%     %% aggiussto la matrice degli indici se la scacchiera è girata
%     indici = indici(:, :, rotazione);
%     if rotazione > 1
%         angolo = -90 * (rotazione - 1);
%         indici = imrotate(indici, angolo);
%     end
            
    
    %% chiamata della funzione che compone la stringa fen
    fen = fenSting(indici);
    
    
    
    
    
%     %% for per ciclare su tutte le caselle
%     for i = 1 : 8
%         for j = 1 : 8
%             cella = cells{i, j}; % cella corrente
%             maxCorrValue = zeros(1, 4);
%             
%             for k = 3 : 28 % confronto con tutti i pezzi possibili
%                 if k ~= 20
%                     chess = dataset(k).Image; %template corrente
%                     for h = 1 : 4
%                         if indici(i, j, h) ~= 1
%                             correlationOutput = normxcorr2(chess, cella); % ricerca del tamplate
%                             % Find out where the normalized cross correlation image is brightest.
%                             corrValue = max(abs(correlationOutput(:)));
%                             if corrValue > maxCorrValue(1, h)
%                                 maxCorrValue(h) = corrValue;
%                                    % Because cross correlation increases the size of the image, 
%                                 % we need to shift back to find out where it would be in the original image.
%                                 indici(i, j, h) = k;
%                                 scores(i, j, h) = maxCorrValue(h);
%                                 if k == 26 || k == 27 || k == 28 || k == 29 
%                                     scores(i, j, h) = 0;
%                                 else
%                                     scores(i, j, h) = maxCorrValue(1, h);
%                                 end
%                                 if maxCorrValue(h) < 0.
%                                     scores(i, j, h) = 0;
%                                 end
%                             end
%                             chess = rot90(chess);
%                         end
%                     end
%                 end
%             end
%         end
%     end
% 
%     punteggio(1) = sum(sum(scores(:, :, 1)));  %0
%     punteggio(2) = sum(sum(scores(:, :, 2)));  %90
%     punteggio(3) = sum(sum(scores(:, :, 3)));  %180
%     punteggio(4) = sum(sum(scores(:, :, 4)));  %270
% 
%     [m, rotazione] = max(punteggio);
%     
%     %% aggiussto la matrice degli indici se la scacchiera è girata
%     indici = indici(:, :, rotazione);
%     if rotazione > 1
%         angolo = -90 * (rotazione - 1);
%         indici = imrotate(indici, angolo);
%     end
%             
%     
%     %% chiamata della funzione che compone la stringa fen
%     fen = fenSting(indici);
end