function [ak, f] = backtrackingls(theta, pk, rho_ls, c)
    ak = 1;
    [f, g, ~] = compute_function(theta);
    t = compute_function(theta + ak * pk);
    wf = f + c * ak * g' * pk;
    while t > wf
        ak = rho_ls * ak;
        t = compute_function(theta);
        wf = f + c * ak * g' * pk;
    end
end