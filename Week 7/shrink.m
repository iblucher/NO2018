function s = shrink(v)
    l = size(v, 1);
    v1 = v(1:l/2);
    v2 = v(l/2 + 1 : l);
    s = v1 - v2;
end