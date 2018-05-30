function out = chessTrasform (chess, convexImage, debug, dim)
    [r, c, ~] = size(convexImage);
    chess = imresize(chess, [r, c]);
    chess = padarray(chess, [5, 5]);
    convexImage = padarray(convexImage, [5, 5]);

    %% 1. Get rid of the white border
    I2 = imclearborder(convexImage);
    %% 2. Find each of the four corners
    [y,x] = find(I2); % riga = y column = x
    [~,loc] = min(y+x); %posizione della somma minima
    C = [x(loc),y(loc)]; %trovo lre cordinate del punto la cui somma è la minore possibile 
    [~,loc] = min(y-x);
    C(2,:) = [x(loc),y(loc)];
    [~,loc] = max(y+x);
    C(3,:) = [x(loc),y(loc)];
    [~,loc] = max(y-x);
    C(4,:) = [x(loc),y(loc)];
    %% 3. Find the locations of the new  corners
    L = mean(C([1 4],1));
    R = mean(C([2 3],1));
    U = mean(C([1 2],2));
    D = mean(C([3 4],2));
    C2 = [L U; R U; R D; L D];
    %% 4. Do the image transform
    T = fitgeotrans(C ,C2,'projective');
    IT = imwarp(convexImage,T); %IM2BW is not necessary
    chess = imwarp(chess,T);

    chessB  = regionprops(IT, 'boundingBox');
    
    d = imcrop (chess, (chessB(1).BoundingBox(:)));
    out = imresize(d, dim);
    
    %% stampa bounding-Box
    if debug == 1
        figure, imshow(IT), title('image with bounding boxs')
        hold on
         for i = 1 : length(chessB);
             CurrBB = chessB(i).BoundingBox;
             rectangle('Position', [CurrBB(1), CurrBB(2), CurrBB(3), CurrBB(4)], 'EdgeColor', 'r', 'LineWidth', 2)
         end
        hold off
        figure, imshow(d), title('Mia ritaglaita');
    end
end