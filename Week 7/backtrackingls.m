function ak = backtrackingls(theta, pk, rho_ls, c, phi, lambda, rho, x, y)
    ak = 1;
    [f, g, ~] = compute_theta(theta, phi, lambda, rho, x, y);
    t = compute_theta(theta + ak * pk, phi, lambda, rho, x, y);
    wf = f + c * ak * g' * pk;
    while t > wf + 1e-4
        ak = rho_ls * ak;
        t = compute_theta(theta + ak * pk, phi, lambda, rho, x, y);
        wf = f + c * ak * g' * pk;
    end
end 