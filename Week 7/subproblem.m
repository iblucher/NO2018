function [pn, qn, alphan, dist, k] = subproblem(q0, alpha0, mu, delta, theta, x, y, lambda)
    
    % initialize variables
    tol = 1e-6;
    max_iter = 1e4;
    new = 1;
    
    k = 1;
    diff = 1;
    d = size(theta, 1);
    p = zeros(2*d, max_iter);
    p(:, 1) = ones(2*d, 1);
    q = zeros(2*d, max_iter);
    q(:, 1) = q0;
    alpha = zeros(2*d, max_iter);
    alpha(:, 1) = alpha0;
    
    dist = zeros(max_iter, 1);
    
    while norm(diff) > tol && norm(new) ~= 0 && k < max_iter
        [~, g, B] = compute_function_trust(theta, x, y, lambda);
        
        grad = g + B * p(:, k) + mu * (p(:, k) - q(:, k)) - alpha(:, k);
        
        b = size(B, 1);
        hess = B + eye(b) * mu;
        
        % compute Newton step
        p(:, k + 1) = p(:, k) - hess \ grad;
        
        % compute q
        [wp, wm] = reparam(theta);
        new_theta = [wp; wm];
        for i = 1:2*d
            q(i, k + 1) = p(i, k + 1) - alpha(i, k)/mu;
            m = max(-delta, new_theta(i));
            if q(i, k + 1) < m
                q(i, k + 1) = m;
            elseif q(i, k + 1) > delta
                q(i, k + 1) = delta;
            end
        end
        
        % compute lagrange multiplier alpha
        for i = 1:2*d
            alpha(i, k + 1) = alpha(i, k) - mu * (p(i, k + 1) - q(i, k + 1));
        end
        
        old_diff = diff;
        
        % check if p and q are very close
        diff = p(:, k + 1) - q(:, k + 1);
        dist(k) = norm(diff);
        norm(diff)
        
        new = diff - old_diff;
        
        
        % iteration counter
        k = k + 1;
    end
    
    p = p(:, 1:k);
    q = q(:, 1:k);
    alpha = alpha(:, 1:k);
    dist = dist(1:k, 1);
    
    pn = p(:, end);
    qn = q(:, end);
    alphan = alpha(:, end);
    
end