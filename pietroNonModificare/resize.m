%%  questa classe si occupa di fare una resize porrtando x e y minori = a 1000 px manrtenendo le giuste proporzioni

function [imageResized,scale] = resize (imageOriginal)
    resized = NaN;
    [x,y,~] = size(imageOriginal);
    
    %fondamentale che imresize mantiene le proporzioni
    resized = NaN;
    if (x > 1042)
        resized = imresize(imageOriginal, [1042 NaN]);
    end
    if (y > 1042)
        resized = imresize(imageOriginal, [NaN 1042]);
    end
    if (~isnan(resized))
        [hr, ~] = size (resized);
    else
        resized = imageOriginal;
        hr=1; %manteniamo la scala originale 
    end 
    scale = x/hr;
    imageResized = resized;
end
