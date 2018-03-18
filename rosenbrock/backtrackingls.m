function [ak, fxk] = backtrackingls(xk, pk, rho, c)
    ak = 1;
    fxk = rosenew(xk);
    while (rosenew(xk + ak * pk) > fxk + c * ak * rosegrad(xk)' * pk)
        ak = rho * ak;
    end
end