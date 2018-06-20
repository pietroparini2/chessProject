close all  
clear
clc

%% partenza cronometro fase iniziale
t0 = clock;

%% fase di inizziazione e preparazione
a = 61;
b = 64;
images = readImages(a,b);
test= zeros(1, (b-a+1));

if exist('pieces.mat', 'file') == 2
    pieces = load('pieces.mat');
    pieces = pieces.pieces;
    piecesB = load('piecesB.mat');
    piecesB = piecesB.piecesB;
else
    [pieces, piecesB] = makeDataset(46);
    save('pieces', 'pieces'); %nome che si vuoledare e poi variabile
    save('piecesB', 'piecesB');
end

fen = cell(1, b-a+1);
risultati = cell(1, b-a+1);

%Stampa tempo 
t1 = etime(clock,t0);
fprintf('tempo per fase di inizializzazione %.2f seconds.\n\n', t1);

for i=1:(b-a+1)
    t0 = clock;
    
    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    [straightChess, choose]= chooseElaboration(imageResized,scale,original);
    
    
    %% mettere da qualche altra parte
    k = 7;
    straightChess = straightChess(k+1:end-k,k+1:end-k, :);
    chessboard = imadjust(rgb2gray(straightChess)); %, [0.01 0.6], []
   
    %% chiamata al metodo
    [fen{i}, rotazione, risultati{i}] = fenGenerator(chessboard, pieces, piecesB);
    
    %% per visualizzare scacchiera girata
    chessboard = imrotate(chessboard, rotazione);
    figure, imshow(chessboard);        
    
    %% stampa posizione risultato e tempo
    t1 = etime(clock,t0);
    
    pOut = sprintf('immagine %d: %.2f - tempo impiegato: %.2f seconds.\n',a+i-1,risultati{i}, t1); %s per stringa
    disp(pOut);
end