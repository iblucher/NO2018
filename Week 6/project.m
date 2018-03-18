function p = project(x, m, M, p)
    len = size(m, 1);
    for i = 1:len
        if x(i) == m(i)
            if p(i) < 0
                p(i) = 0;
            end
        elseif x(i) == M(i)
            if p(i) > 0
                p(i) = 0;
            end
        end
    end
end