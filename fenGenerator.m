function [fen, angle] = fenGenerator (chessboard, pieces, piecesB) 
    
    %% chiamata al metodo per estrarre le celle
    cells = findSquare(chessboard, 0);

    scores = zeros(8, 8, 4);
    indici = zeros(8, 8, 4);
    
    %% ricerca re
    for i = 1 : 8
        for j = 1 : 8
            cella = cells{i,j};
            king1 = pieces{1};
            king2 = pieces{2};
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
    if correct == 1 || correct == 3
        cellW = 1;
    end
    
    maxScores = zeros(8, 8);
    %% riconoscimento altri pezzi
    for i = 1 : 8
        for j = 1 : 8
            cella = cells{i, j}; % cella corrente
            maxCorrValue = zeros(1);
            
            if indici(i, j) ~= 1
                for k = 3 : 32
                    chess = piecesB{k}; %template corrente
                    
                    %giro il template nella direzione giusta
                    if correct ~= 1
                        for h = 1 : (correct-1)
                            chess = rot90(chess);
                        end
                    end
                    
                    % calcolo la correlazione con il template corrente
                    correlationOutput = normxcorr2(chess, cella);
                    % Cerco nell'immagine dove la correlazioine normalizzata � piu forte
                    corrValue = max(abs(correlationOutput(:)));
                    if corrValue > maxCorrValue
                        maxCorrValue = corrValue;
                        indici(i, j) = k;
                        maxScores(i, j) = maxCorrValue;
                        if k == 17 || k == 18 || k == 31 || k == 32 
                            maxScores(i, j) = 0;
                        else
                            maxScores(i, j) = maxCorrValue;
                        end
                    end
                
                
                
                
                %% prova per migliorare riconoscimento
%                 if  maxScores(i, j) < 0.55
%                     for k = 3 : 32
%                         chess = piecesB{k}; %template corrente
% 
%                         %giro il template nella direzione giusta
%                         if correct ~= 1
%                             for h = 1 : (correct-1)
%                                 chess = rot90(chess);
%                             end
%                         end
% 
%                         % calcolo la correlazione con il template corrente
%                         correlationOutput = normxcorr2(chess, cella);
%                         % Cerco nell'immagine dove la correlazioine normalizzata � piu forte
%                         corrValue = max(abs(correlationOutput(:)));
%                         if corrValue > maxCorrValue && corrValue > maxScores(i,j)
%                             maxCorrValue = corrValue;
%                             indici(i, j) = k;
%                             maxScores(i, j) = maxCorrValue;
%                             if k == 17 || k == 18 || k == 31 || k == 32 
%                                 maxScores(i, j) = 0;
%                             else
%                                 maxScores(i, j) = maxCorrValue;
%                             end
%                         end
%                     end
                end                
            end
            

        end
    end
    
    %% giro la matrice degli indici per averla nel senso corretto
    angle = 0;
    if correct ~= 1
        angle = -90 * (correct-1);
        indici = imrotate(indici, angle);
    end
    
    %% chiamata della funzione che compone la stringa fen
    fen = fenSting(indici);
    
end