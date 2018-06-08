close all, clear, clc;

%% generare stringhe fen

a=1;
b=1;
images = readImages(a,b);
test= zeros(1, (b-a+1));

dataset = makeDataset(46);
fen = cell(1, b-a+1);

for i=1:(b-a+1)

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    imageTest = mainElaboration(imageResized);  % classe di test già sviluppata
    chessBox   = chessDiscover(imageTest, scale, original); % classe di test già sviluppata
    straightChess= straightensChess(chessBox.Image,chessBox.ConvexImage);
    
    
    %% mettere da qualche altra parte
    k = 7;
    im = straightChess;
    im = im(k+1:end-k,k+1:end-k, :);
    imA = imadjust(rgb2gray(im));
    figure, imshow(imA);
    
    
    cells = findSquare(imA, 0);
    fen{i} = fenGenerator(cells, dataset); 
end