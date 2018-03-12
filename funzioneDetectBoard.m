
%funzione che ha lo scopo di prendere in input un immagine binaria e
%calcolare le linee presenti nell'immmagine 


   

    %Metodo 2
    %I = rgb2gray(s15);
    %se = strel('disk', 5);
    %I = im2double(imbinarize(imopen(I, se)));
    %I = imbinarize(imgaussfilt(im2double(I), 10));

    % Load image
    %I = rgb2gray(im2double(imread('Foto/015.jpg')));

    % Compute edge image
    BW = edge(I,'canny');

    % Compute Hough transform
    [H theta rho] = hough(BW);

    % Find local maxima of Hough transform
    numpeaks = 19;
    thresh = ceil(0 * max(H(:)));
    P = houghpeaks(H,numpeaks,'threshold',thresh);

    % Extract image lines
    lines = houghlines(BW,theta,rho,P,'FillGap',50,'MinLength',60);

    %--------------------------------------------------------------------------
    % Display results
    %--------------------------------------------------------------------------
    % Original image
    %figure; imshow(I), title('originale');

    % Edge image
    %figure; imshow(BW), title('edge image');

    % Hough transform
    %figure; image(theta,rho,imadjust(mat2gray(H)),'CDataMapping','scaled');
    %hold on; colormap(gray(256));
    %plot(theta(P(:,2)),rho(P(:,1)),'o','color','r');

    % Detected lines
    %figure; imshow(I); hold on; n = size(I,2);
   
    output= lines;


