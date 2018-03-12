function output=funzioneDetectBoard(x, y, In)
    for n = x:y
        I = In{n};
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

        % Detected lines stampa immagine con linee
        figure; imshow(I); hold on; n = size(I,2);
        for k = 1:length(lines)
            % Overlay kth line
            x = [lines(k).point1(1) lines(k).point2(1)];
            y = [lines(k).point1(2) lines(k).point2(2)];
            line = @(z) ((y(2) - y(1)) / (x(2) - x(1))) * (z - x(1)) + y(1);
            plot([1 n],line([1 n]),'Color','r');
        end
    end
    output = lines; %al momento non è utilizzato
end