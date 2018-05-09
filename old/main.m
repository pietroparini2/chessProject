clc; close all; clear all;

% lettura immagini
x= 1;   %dall'immagine x 
y= 10;   %all'immagine y
images = readImages(x, y);

%elaborazione immagine (riceve delle immagini a colori in double)
BW = elaborazione1(x, y, images);
%BW = elaborazione2(x, y, images);

%tracciamento linee
lines = funzioneDetectBoard(x, y, BW);
