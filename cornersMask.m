function out = cornersMask(mask)
% riga = y column = x
[y,x] = find(mask); 
    %posizione della somma minima
    [~,loc] = min(y+x); 
    C = [x(loc),y(loc)]; 
    [~,loc] = min(y-x);
    C(2,:) = [x(loc),y(loc)];
    [~,loc] = max(y+x);
    C(3,:) = [x(loc),y(loc)];
    [~,loc] = max(y-x);
    C(4,:) = [x(loc),y(loc)];
    out= C;
end

