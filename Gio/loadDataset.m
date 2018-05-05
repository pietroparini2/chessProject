function outDataset = loadDataset (dimPezzo)
    % Load the dataset images resizing to a numSections x numSections image.
    assert (isnumeric (dimPezzo), 'Number of section must be numeric');
    
    dataset(9) = struct('Image', zeros(dimPezzo, dimPezzo));
    for i = 1 : 9
        im = im2double (imread(strcat('pezziScacchi/', int2str(i), '.png')) );
        im = rgb2gray (im);
        stats = regionprops(~im, 'Image');
        vec = imresize (im2double ((stats(1).Image) == 0), ...
            'Output', [dimPezzo, dimPezzo]);
        vec = imbinarize (vec);

        data = struct('Image', vec);
        dataset(i) = data;
    end
    
    outDataset = dataset;
end