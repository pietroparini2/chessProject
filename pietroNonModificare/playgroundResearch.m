function out = playgroundResearch(rMax)
    %cerco il punto piu in alto a sinistra(con somma fra riga e colonna minore) e il punto in basso a destra(con somma fra riga e colonna maggiore)
    s = sum(rMax.PixelList,2);
    [m, top_left_index] = min(s);
    [m, bottom_right_index] = max(s);
    
    %cerco il punto più in basso a sinistra(con differenza fra riga e colonna minore) e in alto a destra(con differenza fra riga e colonna maggiore)
    d = diff(rMax.PixelList,[],2);
    [m, top_right_index] = max(d);
    [m, bottom_left_index] = min(d);

    %seleziono solo le righe corrispondenti ai vertici
    out = rMax.PixelList([top_left_index bottom_left_index bottom_right_index top_right_index top_left_index],:);

end