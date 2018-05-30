close all; clear all; clc;

%% utilizzati
debugBwImage = 0;
debugChessBox = 0;
debugShearChess = 0;
debugChessSqaure = 0;

%% non ancora utilizzati
debugEdgeResult = 0;
debugRegistrationResult = 0;


%% applicazione programma dall'immagine x a y
<<<<<<< HEAD
x = 20;
y = 23;
=======
x = 1;
y = 2;
>>>>>>> 4d36bf2530a739c258a17a62b0fec54ebeba2799
w = y-x+1;
%% chiamata lettura immagini
images = readImages(x, y);

%% chiamata funzione per elaborazioni varie
for n=1:w
    %% resize immagini
    [resized, ratio] = resizeImage(images{n});
    
    
    %% immagine in BW
    BW{n} = bwImage(resized, debugBwImage);
    %figure, imshow(BW{n}), title('BW image');
    
    %% find chessboard /sto guardando solo una bounding box su due richieste
    chessBox  = chessDiscover(BW{n}, 2, debugChessBox, resized);%2--> chiede due bb più grand
    chess = imcrop (images{n}, (chessBox(1).BoundingBox(:)) .* ratio); %-->effettivamente guarda solo la prima con i : metto in colonna
    convexImage= im2uint8 (chessBox(1).ConvexImage);%maschera della scacchiera
    %figure, imshow(chess), title('BoundingBox Chessboard');
    
    %% 'raddrizza' scacchiera e altre operazioni
    imageFocused = chessTrasform(chess, convexImage, debugShearChess, [400, 400]); %radrizzare la mascchera e tira fuori l'immagine raddrizzata
    
    %% correzione colore al momento non necessaria (white balance)
    %imageFocused = whiteBalance(imageFocused);
    
   %% parte due
    
    %% creazione dataset dei pezzi
    dataset = makeChessPiecesDataset(16);
    %figure, imshow(dataset(1).Image);
    
    %% ritaglio le varie celle
    %cells = findSquare(imageFocused, 16, debugChessSqaure);
    
    %% ultimo comando di ocrSudoku
    %[stringSudoku, debugValues] = ocrCells (cells, dataset);
end
    
    