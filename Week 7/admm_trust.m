function final_theta = admm_trust(q0, alpha0, theta0, mu, delta_max, lambda)

    [x, y] = gen_data(10, 20);

    % initialize variables
    tol = 1e-6;
    max_iter = 1e4;
    k = 1;
    
    delta = nan(max_iter);
    theta = nan(size(x, 2), 1);
    theta(:, k) = theta0;
    
    gx = 1; 
    
    while norm(gx) > tol && k < max_iter
        % obtain pk from admm method
        [p, q, alpha] = subproblem(q0, alpha0, mu, delta(k), theta(:, k), x, y, lambda);
        
        % evaluate rho
        [fx, gx, hx] = compute_function_trust(theta(:, k), x, y, lambda);
        fp = compute_function_trust(theta(:, k) + p, x, y, lambda);
        m0 = 0;
        mk = 0;
        for i = 1:2*d
            m0 = m0 + 0.5 * mu * q(i)^2 - alpha(i) * q(i);
            mk = mk + 0.5 * mu * (p(i) - q(i))^2 - alpha(i) * (p(i) - q(i));
        end
        m0 = fx + m0;
        mk = fx + gx' * p + 0.5 * p' * hx * p + mk;
        
        rho = (fx - fp) / (m0 - mk);
        
        % calculate new delta and x_k+1 with radius size algorithm
        [delta(k + 1), theta(:, k + 1)] = radiussize(rho, delta(k), delta_max, theta(:, k), p, eta, tol);
        
        % iteration counter
        k = k + 1;
        
    end
    
    theta = theta(:, 1:k);
    final_theta = theta(:, end);
end