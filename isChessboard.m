function flag = isChessboard(testChessboard)

 testChessboard =rgb2gray(testChessboard);
 test= imread('./Foto/test/test1.jpg');
 [x,y,~]=size(test);
 
  test =rgb2gray (test);
  test=imbinarize(test);
  
  testChessboard=imbinarize(testChessboard);
  
  test=imopen(test , strel ('disk', 3));
  testChessboard= imopen(testChessboard , strel ('disk', 3));
  
  figure, subplot(1,2,1), imshow(test)
          subplot(1,2,2), imshow(testChessboard);
 
 
 
 imageResized = imresize(testChessboard, [x,y]);
 
 R=corr2(test,imageResized);
 flag=R;
 

end

