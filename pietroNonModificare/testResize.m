%% calsse di test per la funzione di resize
%i title vanno quando vogliono loro, non farci caso

imageTest = imread('immaginiScacchi/004.jpg');
[x,y,~] = size (imageTest);

figure, imshow(imageTest), title(strcat((num2str(x)), 'x',(num2str(y))));
[imageAfterResize, scale]= resize(imageTest);
[m,n,~] = size (imageAfterResize);

figure, imshow(imageAfterResize), title(strcat('scale :', num2str(scale)));

%se la variabile test è true sta funzionando tutto bene
test=((m * scale >= (x-1))&&(m * scale <= (x+1)));