function [ak, fxk] = backtrackingls(xk, pk, rho_ls, c)
    ak = 1;
    fxk = rosenew(xk);
    while (rosenew(xk + ak * pk) > fxk + c * ak * rosegrad(xk)' * pk)
        ak = rho_ls * ak;
    end
end