close all  
clear
clc

%% fase di inizziazione e preparazione
a = 9;
b = 10;
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

for i=1:(b-a+1)
    %% chiamata del metodo per estrarre la scacchiera
    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    [straightChess, choose]= chooseElaboration(imageResized,scale,original);
    
    %% chiamata al metodo per generare stringa fen
    [fen{i}, rotazione, risultati{i}] = fenGenerator(straightChess, pieces, a+i-1);
    
    %% stampa posizione risultato e tempo
    if size(risultati{i}, 2) == 1
        pOut = sprintf('immagine %d:\n  corretta al = %d%%\n  FEN = %s \n', a+i-1, risultati{i}, fen{i}); %s per stringa
        disp(pOut);
    else
        pOut = sprintf('immagine %d:\n  corretta al = %.2f%%\n  FEN = %s \n  pezzi sbagliati = %s \n'...
            ,a+i-1,risultati{i}{1}, fen{i}, risultati{i}{2}); %s per stringa
        disp(pOut);
    end 
end