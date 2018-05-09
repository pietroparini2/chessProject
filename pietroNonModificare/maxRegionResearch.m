function out =maxRegionResearch(im)
    rMax = seach_max_region_loop(im);
    playground = search_playground_bounding(rMax);

    % Disegno sulla figura il rettangolo di gioco
    hold on;
    plot(playground(:,1),playground(:,2),'m','linewidth',5);
    
    bb = rMax.BoundingBox;
    bb(1) = bb(1) - 10;
    bb(2) = bb(2) - 10;
    bb(3) = bb(3) + 20;
    bb(4) = bb(4) + 20;
    
    im = imcrop(im, bb);
    
    % Cerco nell'immagine "croppata" la regione di gioco per avere i punti variabili della funzione fitgeotrans
    rMax = seach_max_region_loop(im);
    playground = search_playground_bounding(rMax);
    
    % Routo e trasformo il playground per essere dritto
    T = fitgeotrans(playground(1:4,:), 500 * [0 0; 1 0; 1 1; 0 1],'projective');
    im = imwarp(im,T);
    % dilato i bordi per far si che venga riconosciuto meglio il campo da gioco
    im_dilate = imdilate(im, strel('square', 7));
    
    % L'immagine è dritta, effettuo il crop finale 
    rMax = seach_max_region_loop(im_dilate);
    
    im = imcrop(im, rMax.BoundingBox);
    
    im = imresize(im, [500, 500], 'bicubic');
    
    out = im;
end

function out = seach_max_region_loop(im)
    regions = regionprops(im,'Area','BoundingBox','PixelList');
    num_reg = numel(regions);
    
    max_region = 0;
    region_index = 0;
    for i = 1:1:num_reg
        region_area = prod(regions(i).BoundingBox(3:4));
        if region_area > max_region
            max_region = region_area;
            region_index = i;
        end
    end
    
    out = regions(region_index);

end