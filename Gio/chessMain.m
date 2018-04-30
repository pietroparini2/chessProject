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
x = 1;
y = 1;
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
    chessBox  = chessDiscover(BW{n}, 2, debugChessBox, resized);
    chess = imcrop (images{n}, (chessBox(1).BoundingBox(:)) .* ratio);
    convexImage= im2uint8 (chessBox(1).ConvexImage);
    %figure, imshow(chess), title('BoundingBox Chessboard');
    
    %% 'raddrizza' scacchiera e altre operazioni
    imageFocused = shearBoard(chess, convexImage, debugShearChess);
    
    %% ridimensiono la scacchiera
    imageFocused = resizeChessboard(imageFocused, [400, 400]);
    figure, imshow(imageFocused), title('Scacchiera ridimensionata');
    
    %% correzione colore al momento non necessaria (white balance)
    %imageFocused = whiteBalance(imageFocused);
    
    %%
    cells = findSquare(imageFocused, 16, debugChessSqaure);
    
    %[stringSudoku, debugValues] = ocrCells (cells, dataset);
end
    
    