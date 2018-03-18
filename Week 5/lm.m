function [x, it, ngrad, count] = lm(x_0, meas, bvec, b, voxel)
    max_iter = 1e4;
    tol = 1e-6;
    eta =1e-4;
    delta_max = 1;
    it = nan(1, max_iter);
    x_k = nan(6, max_iter);
    delta = nan(max_iter, 1);
    p_k = nan(6, 1); 
    ngrad = zeros(max_iter, 1);
    t = zeros(max_iter, 1);
    c = size(meas, 2);
    r = zeros(c - 1, 1);
    x_k(:, 1) = x_0;
    delta_0 = 2/3 * delta_max;
    delta(1) = delta_0;
    k = 1;
    it(k) = k;
    [~, g, ~, ~] = tensorfunction(x_k(:, 1), bvec, meas, b, voxel);
    count = 1;
    ngrad(1) = norm(g);
    tic;
    while norm(g) > tol && k < max_iter
        
        [f, g, h, J] = tensorfunction(x_k(:, k), bvec, meas, b, voxel);
        count = count + 1;
        
        c = size(meas, 2);
        D = vec2mat(x_k(:, k));
        for j = 2:c
            uj = bvec(j-1, :);
            ujD = uj * D * uj';
            e = exp(-b * ujD);
            r(j-1) = meas(voxel, j) - meas(voxel, 1) * e;
        end
        
        pgn = -(J' * J)\(J' * r);
        
        if norm(pgn) < delta(k)
            p = pgn;
        else
            fun = @(y) norm(-inv(J' * J + y * eye(6)) * J' * r) - delta(k); 
            lambda = fzero(fun, 0);
            p = -(h + lambda * eye(6))\J' * r;
        end
   
        m_k = 0.5 * norm(r)^2 + p' * J' * r + 0.5 * p' * h * p;
        f_p = tensorfunction(x_k(:, k) + p, bvec, meas, b, voxel);
        count = count + 1;
        m_0 = 0.5 * norm(r)^2;
        
        rho_k = (f - f_p)/(m_0 - m_k);
                
        k = k + 1;
        ngrad(k) = norm(g);
        [delta(k), x_k(:, k)] = radiussize(rho_k, delta(k-1), delta_max, x_k(:, k-1), p, eta, tol);
        it(k) = k;
    end
    time = toc;
    it = it(1:k);
    x_k = x_k(:, 1:k);
    delta = delta(1:k);
    ngrad = ngrad(1:k);
    x = x_k(:, end);
end
