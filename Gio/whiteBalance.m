function rgbImage = whiteBalance(rgbImage)
    grayImage = rgb2gray(rgbImage); % Convert to gray so we can get the mean luminance.
    % Extract the individual red, green, and blue color channels.
    redChannel = rgbImage(:, :, 1);
    greenChannel = rgbImage(:, :, 2);
    blueChannel = rgbImage(:, :, 3);
    meanR = mean2(redChannel);
    meanG = mean2(greenChannel);
    meanB = mean2(blueChannel);
    meanGray = mean2(grayImage);
    % Make all channels have the same mean
    redChannel = uint8(double(redChannel) * meanGray / meanR);
    greenChannel = uint8(double(greenChannel) * meanGray / meanG);
    blueChannel = uint8(double(blueChannel) * meanGray / meanB);
    % Recombine separate color channels into a single, true color RGB image.
    rgbImage = cat(3, redChannel, greenChannel, blueChannel);
end