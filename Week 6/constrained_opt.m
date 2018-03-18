function [sol, k, grad_norm] = constrained_opt(B, c, m, M, x_0)
    % initialize values 
    k = 1;
    tol = 1e-6;
    max_iter = 1e4;
    x = nan(size(B, 1), max_iter);
    x(:, 1) = x_0;
    [~, g] = compute_function(B, c, x_0);
    pg = g;
    
    grad_norm = nan(max_iter, 1);
    grad_norm(1) = norm(pg);
    
    while norm(pg) > tol && k < max_iter
    
        % projection of descent direction (check if x_i is on the lower or
        % upper bound and if yes, set to zero if it gets outside feasbile region)

        ptilde = -g;
        
        % include epsilon value
        p = project(x(:, k), m, M, ptilde);
        
        % compute Newton direction

        qtilde = B \ p;

        % projection of Newton direction

        q = project(x(:, k), m, M, qtilde);

        % find next x within feasible set
        
        low = nan(size(m, 1), 1);
        up = nan(size(M, 1), 1);
        for i = 1:size(m, 1)
            if p(i) > 0
                low(i) = (m(i) - x(i, k)) / q(i);
                up(i) = (M(i) - x(i, k)) / q(i);
            elseif p(i) < 0
                up(i) = (m(i) - x(i, k)) / q(i);
                low(i) = (M(i) - x(i, k)) / q(i);
            end
        end
       
        l = max(max(low), 0);
        u = min(min(up), 1);
        
        if l > u
            break;
        end
        
        alpha = u;
   
        k = k + 1;
        x(:, k) = x(:, k - 1) + alpha * q;
        
        [~, g] = compute_function(B, c, x(:, k));
        
        pg = q;
        grad_norm(k) = norm(pg);
    end
    
    x = x(:, 1:k);
    sol = x(:, k);
    grad_norm = grad_norm(1:k);
end