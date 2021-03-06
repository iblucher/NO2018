function theta_min = newton(theta0, phi, lambda, rho, x, y)
    tol = 1e-6;
    c = 0.5;
    rho_ls = 0.5;
    theta = theta0;
    [f, g, h] = compute_theta(theta, phi, lambda, rho, x, y);
    i = 0;
    while norm(g) > tol 
        p = - h \ g;
        alpha = backtrackingls(theta, p, rho_ls, c, phi, lambda, rho, x, y);
        theta = theta + alpha * p;
        [f, g, h] = compute_theta(theta, phi, lambda, rho, x, y);
    end
    theta_min = f;
end