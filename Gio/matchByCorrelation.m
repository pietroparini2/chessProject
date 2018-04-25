function out_digit = matchByCorrelation(sampleToMatch, dataset)

    scores = zeros(1, 9);
    tmp = sampleToMatch;
    for i = 1 : 9
        scores(i) = corr2 (tmp, dataset(i).Image);
    end
    
    [score, digit] = max (scores);
        
    out_digit.Score = score;
    out_digit.Digit = digit;
    
end
