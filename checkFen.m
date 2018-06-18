function risultato = checkFen(fen)
    
    correctFen = load('correctFen.mat');
    correctFen = correctFen.correctFen;
    
    x = length(fen);
    risultato = zeros(1, x);
    
    for i = 1 : x
        currentString = fen{i};
        correct = 0;
        
        app = union(currentString, correctFen);
        if length(app) == 8
            correct = 1;
        end
        risultato(1, i) = correct;
    end
end