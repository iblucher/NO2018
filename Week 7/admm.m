function [final_theta, dist, k] = admm(theta0, phi0, lambda0, rho, mu, x, y)
    k = 1;
    max_iter = 1e4;
    tol = 1e-6;
    
    % generate dataset (x and y)
    %x = dataset(:, 1:end-1);
    %x = [ones(10, 1) x];
    %y = dataset(:, end);
    
    % initialize variable vectors for all iterations
    l = length(theta0);
    theta = zeros(l, max_iter);
    phi = zeros(l, max_iter);
    lambda = zeros(l, max_iter);
    theta(:, 1) = theta0;
    phi(:, 1) = phi0;
    lambda(:, 1) = lambda0;
    dist = zeros(max_iter, 1);
    
    diff = 1;
    while norm(diff) > tol
        % compute new theta
        %theta(:, k + 1) = newton(theta(:, k), phi(:, k), lambda(:, k), rho, x, y);
        f_theta = @(t) compute_function(t, x, y) + rho/2 * sum((t - (phi(:, k) - lambda(:, k)/rho)).^2);
        feval(f_theta, theta(:, k))
        theta(:, k + 1) = fminunc(f_theta, theta(:, k));
        
        % compute new phi
        phi(:, k + 1) = compute_phi(theta(:, k + 1), lambda(:, k), rho, mu);
        
        % compute new lambda
        lambda(:, k + 1) = lambda(:, k) + rho * (theta(:, k + 1) - phi(:, k + 1));
        
        % increase iteration counter
        k
        k = k + 1;
        
        diff
        diff = theta(:, k) - phi(:, k);
        dist(k, 1) = norm(diff);
    end
    theta = theta(:, 1:k);
    phi = phi(:, 1:k);
    lambda = lambda(:, 1:k);
    
    dist = dist(1:k, 1);
    
    final_theta = theta(:, k);
    
    
end