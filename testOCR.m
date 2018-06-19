close all  
clear 
clc

% in pratica è la classe main poi vedrò di sistemarla
%% generare stringhe fen

a = 1;
b = 3;
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

for i=1:(b-a+1)

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    [straightChess, choose]= chooseElaboration(imageResized,scale,original);
    
    
    %% mettere da qualche altra parte
    k = 7;
    straightChess = straightChess(k+1:end-k,k+1:end-k, :);
    chessboard = imadjust(rgb2gray(straightChess)); %, [0.01 0.6], []
    
    %% chiamata al metodo
    [fen{i}, rotazione] = fenGenerator(chessboard, pieces, piecesB);
    
%     %% per visualizzare scacchiera girata
%     chessboard = imrotate(chessboard, rotazione);
%     figure, imshow(chessboard);
    
    risultati{i} = checkFen(fen{i});
    pOut = sprintf('immagine %d: %d',a+i-1,risultati{i}); %s per stringa
    disp(pOut);
end

%% per controllare se le scacchiere sono state lette correttamente
risultati = checkFen(fen);