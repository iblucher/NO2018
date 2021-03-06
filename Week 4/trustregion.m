function ans = trustregion(delta_max, eta, x_0, max_iter)
    dist = nan(1, max_iter);
    it = nan(1, max_iter);
    x_k = nan(2, max_iter);
    delta = nan(max_iter, 1);
    p_k = nan(2, 1); 
    x_k(:, 1) = x_0;
    dist(1) = norm(x_0 - [1;1]);
    delta_0 = 2/3 * delta_max;
    delta(1) = delta_0;
    [~, g, ~] = rose(x_0);
    tol = 1e-8;
    k = 1;
    it(k) = k;
    while norm(g) > tol && k < max_iter
        [f, g, h] = rose(x_k(:, k));
        pb = -inv(h) * g;
        pu = -((norm(g)^2)/(g'*h*g))*g;
        
        p_k = dogleg(pb, pu, delta(k), f, g, h);
        m_k = f + g'* p_k + 0.5 * p_k' * h * p_k;
        [fp, ~, ~] = rose(x_k(:, k) + p_k);
        rho_k = (f - fp)/(f - m_k);
        
        k = k + 1;
        [delta(k), x_k(:, k)] = radiussize(rho_k, delta(k-1), delta_max, x_k(:, k-1), p_k, eta, tol);
        dist(k) = norm(x_k(:, k) - [1;1]);
        it(k) = k;
    end
    
    it = it(1:k);
    x_k = x_k(:, 1:k);
    delta = delta(1:k);
    ans = x_k(:, end);
    dist = dist(1:k);
    
    plot(it, (delta));
    ylabel('Trust region radius $$\Delta_k$$', 'Interpreter', 'Latex');
    xlabel('Number of iterations');
    hold on;
    legend('0.1', '1', '10');
end

    