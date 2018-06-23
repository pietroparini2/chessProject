close all  
clear
clc

%% partenza cronometro fase iniziale
t0 = clock;

%% fase di inizziazione e preparazione
a = 56;
b = 56;
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

%Stampa tempo 
t1 = etime(clock,t0);
fprintf('tempo per fase di inizializzazione %.2f seconds.\n\n', t1);


for i=1:(b-a+1)
    
    
    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    [straightChess, choose]= chooseElaboration(imageResized,scale,original);
    
    %% chiamata al metodo
    t0 = clock;
    [fen{i}, rotazione, risultati{i}] = fenGenerator(straightChess, pieces, a+i-1);
    
%     %% per visualizzare scacchiera girata
%     chessboard = imrotate(chessboard, rotazione);
%     figure, imshow(chessboard);        
    
    %% stampa posizione risultato e tempo
    t(i) = etime(clock,t0);
    
    pOut = sprintf('immagine %d: %.2f - tempo impiegato: %.2f seconds.\n',a+i-1,risultati{i}, t(i)); %s per stringa
    disp(pOut);
end