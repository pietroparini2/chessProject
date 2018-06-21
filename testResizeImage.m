close all, clear, clc;
a=1;
b=1;
images = readImages(a,b);
test= zeros(1, (b-a+1));

for i=1:(b-a+1)

    imageTest=images{i};
    [x,y,~] = size(imageTest);

    figure, imshow(imageTest), title(strcat((num2str(x)), 'x',(num2str(y))));
    [imageAfterResize, scale]= resizeImage(images{i});
    [m,n,~] = size(imageAfterResize);

    figure, imshow(imageAfterResize), title(strcat('scale :', num2str(scale)));

    %ogni cella dell'array di test deve essere a true 
    test(i)=((m * scale >= (x-1))&&(m * scale <= (x+1)));
end