close all, clear, clc;

% in pratica è la classe main poi vedrò di sistemarla
%% generare stringhe fen

a = 21;
b = 30;
images = readImages(a,b);
test= zeros(1, (b-a+1));

if exist('dataset.mat', 'file') == 2
    dataset = load('dataset.mat');
    dataset = dataset.dataset;
else
    dataset = makeDataset(46);
    save('dataset', 'dataset');
end

fen = cell(1, b-a+1);

for i=1:(b-a+1)

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); % classe di test già sviluppata
    straightChess= chooseElaboration(imageResized,scale,original);
    
    
    %% mettere da qualche altra parte
    k = 7;
    straightChess = straightChess(k+1:end-k,k+1:end-k, :);
    chessboard = imadjust(rgb2gray(straightChess)); %, [0.01 0.6], []
%     chessboard = imadjust(chessboard);
    
    %% chiamata al metodo
    [fen{i}, rotazione] = fenGenerator(chessboard, dataset);
    chessboard = imrotate(chessboard, rotazione);
    figure, imshow(chessboard);
end