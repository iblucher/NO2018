function [wplus, wminus] = reparam(theta)
    d = size(theta, 1);
    wplus = nan(d, 1);
    wminus = nan(d, 1);
    for i = 1:d
        if theta(i) >= 0
            wplus(i)= theta(i);
            wminus(i) = 0;
        elseif theta(i) < 0
            wminus(i) = abs(theta(i));
            wplus(i) = 0;
        end
    end
end