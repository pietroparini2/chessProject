close all, clear, clc;
a=1;
b=20;

images = readImages(a,b);
test= zeros(1, (b-a+1));
elaboration=zeros(1, (b-a+1));


for i=1:(b-a+1)

    original = images{i};
    [imageResized, scale] = (resizeImage(original)); 
    [imageTest, choose]= chooseElaboration(imageResized,scale,original);  
    elaboration(i)=choose;
    figure, subplot(1,2,1), imshow(original),
            subplot(1,2,2), imshow(imageTest),
            
end