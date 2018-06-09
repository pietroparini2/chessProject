function flag = isChessboard(testChessboard)

 testChessboard =rgb2gray(testChessboard);
 testModel= imread('./Foto/test/test1.jpg');
 [x,y,~]=size(testModel);
 
  testModel =rgb2gray (testModel);
  testModel=imbinarize(testModel);
  
  testChessboard=imbinarize(testChessboard);
  
  testModel=imopen(testModel , strel ('disk', 3));
  testChessboard= imopen(testChessboard , strel ('disk', 3));
  
  %%da mettere cme debug
%   figure, subplot(1,2,1), imshow(testModel)
%           subplot(1,2,2), imshow(testChessboard);

 imageResized = imresize(testChessboard, [x,y]);
 
 R=corr2(testModel,imageResized);
 flag=R;
 

end

