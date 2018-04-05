function final_theta = admm_trust(q0, alpha0, theta0, mu, delta0, delta_max, lambda)

    [x, y] = gen_data(10, 20);

    % initialize variables
    tol = 1e-6;
    max_iter = 1e4;
    k = 1;
    d = size(x, 2);
    eta = 1e-4;
    
    delta = nan(max_iter);
    delta(k) = delta0;
    theta = nan(d, max_iter);
    theta(:, k) = theta0;
    
    gx = 1; 
    
    while norm(gx) > tol && k < max_iter
        % obtain pk from admm method
        [p, q, alpha] = subproblem(q0, alpha0, mu, delta(k), theta(:, k), x, y, lambda);
        
        % evaluate rho
        [fx, gx, hx] = compute_function_trust(theta(:, k), x, y, lambda);
        
        % reparameterize current theta
        [w1, w2] = reparam(theta(:, k));
        t = [w1; w2];
        v = shrink(t + q);
        
        % calculate rho elements
        fp = compute_function_trust(v, x, y, lambda);
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
        [delta(k + 1), t] = radiussize(rho, delta(k), delta_max, t, p, eta, tol);
        theta(:, k + 1) = shrink(t);
        
        % iteration counter
        k = k + 1;
        
        k
        norm(gx)
        
    end
    
    theta = theta(:, 1:k);
    final_theta = theta(:, end);
end