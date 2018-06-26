close all  
clear
clc

%% partenza cronometro fase iniziale
t0 = clock;

%% fase di inizzizione e preparazione
a = 21;
b = 21;
images = readImages(a,b);
test= zeros(1, (b-a+1));


if exist('pieces.mat', 'file') == 2
    pieces = load('pieces.mat');
    pieces = pieces.pieces;
else
    pieces = makeDataset(46);
    save('pieces', 'pieces'); %nome che si vuoledare e poi variabile
end

fen = cell(1, b-a+1);
risultati = cell(1, b-a+1);
t = zeros(1, b-a+1);

%% Stampa tempo fase di inizzializzazione
t1 = etime(clock,t0);
fprintf('tempo per fase di inizializzazione %.2f seconds.\n\n', t1);

for i=1:(b-a+1)
    %% chiamata del metodo per estrarre la scacchiera
    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    [straightChess, choose]= chooseElaboration(imageResized,scale,original);
    
    %% chiamata al metodo per generare stringa fen
    t0 = clock;
    [fen{i}, rotazione, risultati{i}] = fenGenerator(straightChess, pieces, a+i-1);
    t(i) = etime(clock,t0);
    
    %% per visualizzare scacchiera girata correttamente
    straightChess = imrotate(straightChess, rotazione);
    figure, imshow(straightChess);
    
   
    %% stampa posizione risultato e tempo
    if size(risultati{i}, 2) == 1
        pOut = sprintf('immagine %d:\n  corretta al = %d%% \n  FEN = %s \n  tempo impiegato = %.2f seconds.\n'...
            , a+i-1, risultati{i}, fen{i}, t(i));
        disp(pOut);
    else
        pOut = sprintf('immagine %d:\n  corretta al = %.2f%% \n  FEN = %s \n  pezzi sbagliati = %s \n  tempo impiegato = %.2f seconds. \n' ...
                     , a+i-1, risultati{i}{1}, fen{i}, risultati{i}{2}, t(i));
        disp(pOut);
    end 
end

%% creazione matrice di confusione
    [confMat, nCorrette]= confusionMat(fen,a,b);