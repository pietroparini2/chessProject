function out = cornersMask(mask)
[y,x] = find(mask); % riga = y column = x
    [~,loc] = min(y+x); %posizione della somma minima
    C = [x(loc),y(loc)]; 
    [~,loc] = min(y-x);
    C(2,:) = [x(loc),y(loc)];
    [~,loc] = max(y+x);
    C(3,:) = [x(loc),y(loc)];
    [~,loc] = max(y-x);
    C(4,:) = [x(loc),y(loc)];
    out= C;
end

