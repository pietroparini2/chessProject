clear, clc, close all; 

%% fase di inizziazione e preparazione
a = 11;
b = 20;
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
    original = images{i};
    
    %% rierca, ritaglio e riaddrizzamento della scacchiera
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    [straightChess, choose]= chooseElaboration(imageResized,scale,original);
    
    %% riconoscimento dei pezzi e creazione delle stringhe fen
    [fen{i}, rotazione, risultati{i}] = fenGenerator(straightChess, pieces, a+i-1);
    
    %% stampa dei risultati
    pOut = sprintf('immagine %d:\n riconosciuta al = %.2f percento \n fen costruita = %s \n',a+i-1,risultati{i}, fen{i}); %s per stringa
    disp(pOut);
end