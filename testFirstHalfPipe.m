close all, clear, clc;
a=48;
b=70;

images = readImages(a,b);
test= zeros(1, (b-a+1));
elaboration=zeros(1, (b-a+1));
times=zeros(1, (b-a+1));


for i=1:(b-a+1)

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); 
    t0 = clock;
    [imageTest, choose]= chooseElaboration(imageResized,scale,original);
    t1 = etime(clock,t0);
    fprintf('immagine: %d \n elaborazione usata: %d \n in tempo %.2f seconds.\n\n',i, choose,  t1);
    times(i)=t1;
    elaboration(i)=choose;
     figure, subplot(1,2,1), imshow(original),
             subplot(1,2,2), imshow(imageTest),
            
end

