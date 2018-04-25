dataset = loadDataset (16);

% TODO solve strong shadow issues

% im = imread ('immagini/1a.jpg');                      %OK
% im = imread ('immagini/1b.jpg');                      %FAIL
% (The film hide some digit)

% im = imread ('immagini/2a.jpg');                      %OK
% im = imread ('immagini/2b.jpg');                      %OK
% im = imread ('immagini/3a.jpg');                      %OK
% im = imread ('immagini/3b.jpg');                      %OK
% im = imread ('immagini/3c.jpg');                      %OK
% im = imread ('immagini/4.jpg');                       %OK 

% im = imread ('immagini/5.jpg');                       %OK

% im = imread ('immagini/6.jpg');                       %OK
% im = imread ('immagini/7.jpg');                       %OK

% im = imread ('immagini/8a.jpg');                      %FAIL (The shadow eats
% some digits and makes impossible to compute the treshold value
% using Otsu)

% im = imread ('immagini/8b.jpg');                      %OK
% im = imread ('immagini/9.jpg');                       %OK

% im = imread ('immagini/20161128_112813.jpg');         %OK
% im = imread ('immagini/20161128_112824.jpg');         %OK
% im = imread ('immagini/20161128_112838.jpg');         %OK
% im = imread ('immagini/20161128_112847.jpg');         %OK
% im = imread ('immagini/20161128_112900.jpg');         %OK
% im = imread ('immagini/20161128_112909.jpg');         %OK
% im = imread ('immagini/20161128_112918.jpg');         %OK
% im = imread ('immagini/20161128_112932.jpg');         %OK
% im = imread ('immagini/20161128_112949.jpg');         %OK

% im = imread ('immagini/20161128_113402.jpg');         %OK

% im = imread ('immagini/20161128_113502.jpg');         %FAIL (It's heavily
% blurred)

% im = imread ('immagini/20161128_115306.jpg');         %OK
% im = imread ('immagini/20161128_115502.jpg');         %FAIL
% (The image is blurred, so during the binarization the digits are made
% too much big that some of them do not respect the size parameter for the 
% label selection. In addition, this problem affect even the computation
% of the correlation).

% im = imread ('immagini/20161128_120154.jpg');         %OK
% im = imread ('immagini/20161128_121059.jpg');         %OK
% im = imread ('immagini/20161128_121120.jpg');         %FAIL heavily
% blurred (gets some digits)


% im = imread ('immagini/20161128_121139.jpg');         %OK
% im = imread ('immagini/20161128_113241027.jpg');      %OK
% im = imread ('immagini/20161128_113312363.jpg');      %OK
% im = imread ('immagini/IMG_20161128_114847.jpg');     %OK
% im = imread ('immagini/IMG_20161128_120727.jpg');     %FAIL
% (Hard shadow cuts some cells in the middle, making the binarization
% errorprone)

% im = imread ('immagini/IMG_20161129_111305.jpg');     %OK (soft shadow don't
% creates problems)

% im = imread ('immagini/IMG_20161129_111413.jpg');     %OK
% im = imread ('immagini/IMG_20161129_111434.jpg');     %OK
% im = imread ('immagini/IMG_20161129_111447.jpg');     %OK
% im = imread ('immagini/IMG_20161129_111512.jpg');     %OK
% im = imread ('immagini/IMG_20161129_111622.jpg');     %FAIL
% (The hard shadow produced by the bottle cuts some cells in the middle.)

im = imread ('immagini/IMG_20161129_111710.jpg');     %OK
% (Although the is a strong source of light, the light on the sudoku is
% uniform, so otsu works grat in this case).

% im = imread ('immagini/IMG_20161129_111747.jpg');     %FAIL
% A key overlapped a digit, so the digit label is connected to the key
% label and this makes the whole digit label to not respect the size
% properties during the digit extraction from the cell.

% im = imread ('immagini/IMG_20161129_111916.jpg');     %OK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MIO DATASET: solo qualche immagine per vedere casi particolari, oltre
% che per testare altre immagini. Per queste immagini non � stata preparata
% una groundtruth. Si � verificata quindi manualmente la correttezza.
% Queste immagini non sono prese in considerazione nel calcolo della
% matrice di confusione.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% im = imread ('mio_dataset\DSC_0414.png');             %OK
% im = imread ('mio_dataset\DSC_0417.png');             %OK

% im = imread ('mio_dataset\DSC_0421.png');             %FAIL
% (EPIC FAIL: no sudoku)

% im = imread ('mio_dataset\DSC_0428.png');             %FAIL
% The cell is contaminated by some little arrows that touch the label of
% the digit, making a single label that doesn't repsect the size properties
% for the digit extraction process.

% im = imread ('mio_dataset\DSC_0450.png');             %OK
% im = imread ('mio_dataset\DSC_0461.png');             %FAIL
% The binarization sometimes extract a digit from the other page of the
% sudoku.

% im = imread ('mio_dataset\DSC_0462.png');             %FAIL
% The algorithm supposed that each cell of the sudoku is a square, which is
% not true when the image is particularly twisted.

showEdge = 0;
showEdgeResult = 0;
showSquareResult = 0;
showRegistration = 0;
showRegistrationResult = 0;
showCellProcedure = 0;

[tmpRes, debugValue] = ocrSudoku (im, dataset, ...
    showEdge, ...
    showEdgeResult, ...
    showSquareResult, ...
    showRegistration, ...
    showRegistrationResult, ...
    showCellProcedure);

debugValue.score
tmpRes

fh = figure;
imshow(im)
title (tmpRes);
waitfor(fh);