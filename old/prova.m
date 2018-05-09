clear all ;
close all ;

h = [-1, -2, -1;0, 0, 0; 1, 2 ,1];
s= strel('square', 7);
s1= strel('square',9);



%ciclo per iterare le prove sulle prime n immagini
for(pippo=1:20)
    image{pippo}=rgb2gray(im2double(imread(sprintf('Foto/%03d.jpg',pippo))));
    image{pippo}=sauvola(image{pippo},[50 50]);
     image{pippo}=1-image{pippo};
     
     image{pippo}=imopen(image{pippo},s1);
     %image{pippo}=imdilate(image{pippo},s);
  
     
    %image{pippo}=filter2(h,image{pippo});
    figure, imshow(image{pippo});
end











