clear all;
close all;

im = im2double(imread('scacchiera1.png'));
s15 = im2double(imread('Foto/001.jpg'));


%Metodo1
im1 = rgb2gray(s15);
se = strel('disk', 7);
im1 = im2double(imbinarize(imopen(im1, se)));
imagePoints1 = corner(im1, 'Harris');
imPoints1 = insertMarker(im1, imagePoints1);
%figure, imshow(imPoints1), title('Corner Harris');

%Metodo 2
I = rgb2gray(s15);
se = strel('disk', 5);
I = im2double(imbinarize(imopen(I, se)));
I = imbinarize(imgaussfilt(im2double(I), 10));

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
figure; imshow(I), title('originale');

% Edge image
figure; imshow(BW), title('edge image');

% Hough transform
figure; image(theta,rho,imadjust(mat2gray(H)),'CDataMapping','scaled');
hold on; colormap(gray(256));
plot(theta(P(:,2)),rho(P(:,1)),'o','color','r');

% Detected lines
figure; imshow(I); hold on; n = size(I,2);
for k = 1:length(lines)
    % Overlay kth line
    x = [lines(k).point1(1) lines(k).point2(1)];
    y = [lines(k).point1(2) lines(k).point2(2)];
    line = @(z) ((y(2) - y(1)) / (x(2) - x(1))) * (z - x(1)) + y(1);
    plot([1 n],line([1 n]),'Color','r');
end


