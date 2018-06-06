function flag = isChessboard(testChessboard)

 testChessboard =rgb2gray(testChessboard);
 test= imread('./Foto/test/test1.jpg');
 [x,y,channel]=size(test);
  if channel > 1
     test = rgb2gray (test);
  end
 
 
 
 
 imageResized = imresize(testChessboard, [x,y]);
 
 R=corr2(test,imageResized);
 flag=R;
 

end

