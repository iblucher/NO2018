function theta_min = newton(theta0, phi, lambda, rho)
    tol = 1e-6;
    c = 0.5;
    rho_ls = 0.5;
    theta = theta0;
    [f, g, h] = compute_theta(theta, phi, lambda, rho);
    while norm(g) > tol 
        p = -(h)^-1 * g_theta;
        [fk, alpha] = backtrackingls(theta, p, rho_ls, c);
        theta = theta + alpha * p;
        [~, g, h] = compute_function(theta, phi, lambda, rho);
    end
end