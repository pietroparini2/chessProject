function outDataset = loadDataset (numSections)
    % Load the dataset images resizing to a numSections x numSections image.
    assert (isnumeric (numSections), 'Number of section must be numeric');
    
    dataset(9) = struct('Image', zeros(numSections, numSections));
    for i = 1 : 9
        im = im2double (imread(strcat('cifre/', int2str(i), '.png')) );
        im = rgb2gray (im);
        stats = regionprops(~im, 'Image');
        vec = imresize (im2double ((stats(1).Image) == 0), ...
            'Output', [numSections, numSections]);
        vec = imbinarize (vec);

        data = struct('Image', vec);
        dataset(i) = data;
    end
    
    outDataset = dataset;
end