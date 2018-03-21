function final_theta = admm(theta0, phi0, lambda0, rho, mu)
    k = 1;
    max_iter = 1e4;
    tol = 1e-5;
    
    % generate dataset (x and y)
    [x, y] = gen_data(50, 20);
    
    % initialize variable vectors for all iterations
    l = length(theta0);
    theta = zeros(l, max_iter);
    phi = zeros(l, max_iter);
    lambda = zeros(l, max_iter);
    theta(:, 1) = theta0;
    phi(:, 1) = phi0;
    lambda(:, 1) = lambda0;
    
    diff = 1;
    while norm(diff) > tol
        % compute new theta
        theta(:, k + 1) = newton(theta(:, k), phi(:, k), lambda(:, k), rho, x, y);
        
        % compute new phi
        phi(:, k + 1) = compute_phi(theta(:, k + 1), lambda(:, k), rho, mu);
        
        % compute new lambda
        lambda(:, k + 1) = lambda(:, k) + rho * (theta(:, k + 1) - phi(:, k + 1));
        
        % increase iteration counter
        k = k + 1;
        
        diff = theta - phi;
    end
    theta = theta(:, 1:k);
    phi = phi(:, 1:k);
    lambda = lambda(:, 1:k);
    
    final_theta = theta(:, k);
    
    
end