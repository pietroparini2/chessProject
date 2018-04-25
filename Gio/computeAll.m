function result = computeAll(debug)
    
    if ~exist('debug', 'var')
        debug = 0;
    end

    dataset = loadDataset (16);
    images = textread('images.txt', '%s', 'delimiter', '\n');
    groundtruth = textread('groundtruth_raw.txt', '%s', 'delimiter', '\n');

    correct = 0;
    confmat = zeros (10, 10);
    labels = double ('.123456789') - 48; %from ascii to number
    
    for i = 1 : numel (images)
        strcat('immagini/', images{i})
        im = imread (strcat('immagini/', images{i}));
        tmpRes = ocrSudoku(im, dataset, 0, 0, 0, 0, 0);
        result = double (tmpRes) - 48;
        predicted = double (groundtruth{i}) - 48;
        confmat = confmat + confusionmat (predicted, result, 'order', labels);
        if sum (result - predicted) == 0
            correct = correct + 1;
        elseif debug == 1
            fh = figure;
            tmpRes = ocrSudoku(im, dataset, 0, 0, 0, 0, 0);
            imshow(im)
            title (tmpRes);
            waitfor(fh);            
        end
    
    end
    
    for i = 1 : size (confmat, 1)
        confmat(i, :) = confmat (i, :) ./ sum (confmat(i, :));
    end
    
    result = struct ('recognized', correct, ...
        'total', size (images, 1), ...
        'confmat', confmat);
    
end