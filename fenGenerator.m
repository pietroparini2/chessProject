function fen = fenGenerator (cells, dataset) 
    
    % use normxcorr2 to find a template chess in chessboard

    scores = zeros(8, 8, 4);
    indici = zeros(8, 8, 4);

    punteggio = zeros(1, 4);

    %% for per ciclare su tutte le caselle
    for i = 1 : 8
        for j = 1 : 8
            % current cell
            cella = cells{i, j};
            maxCorrValue = zeros(1, 4);

            % confronto con tutti i pezzi possibili
            for k = 1: 26
                chess = dataset(k).Image;
                for h = 1 : 4
                    % search for a match.
                    correlationOutput = normxcorr2(chess, cella);
                    % Find out where the normalized cross correlation image is brightest.
                    corrValue = max(abs(correlationOutput(:)));
                    if corrValue > maxCorrValue(h)
                        maxCorrValue(h) = corrValue;
                        % Because cross correlation increases the size of the image, 
                        % we need to shift back to find out where it would be in the original image.
                        indici(i, j, h) = k;
                        if k == 1 || k == 26
                            scores(i, j, h) = 0;
                        else
                            scores(i, j, h) = maxCorrValue(h);
                        end
                        if maxCorrValue(h) < 0.6
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
    
    indici = indici(:, :, rotazione);
    if rotazione > 1
        angolo = -90 * (rotazione - 1);
        indici = imrotate(indici, angolo);
    end
            
    
    %% chiamata per funzione composizione stringa
    fen = fenSting(indici);
end