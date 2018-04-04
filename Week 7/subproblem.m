function [pn, qn, alpha] = subproblem(q0, alpha0, mu0, rho, theta, x, y)
    
    % initialize variables
    k = 0;
    diff = 1;
    
    d = size(q, 1);
    
    while diff > tol && k < max_iter
        [f, g, B] = compute_function(theta, x, y);
        
        grad = zeros(d);
        for i = 1:d
            grad(i) = g' + B * p(i) + rho * (p(i) - q(i)) - alpha(i);
        end
        
        hess = zeros(d, d);
        for i = 1:d
            hess(i, i) = B + rho;
        end
        
        % compute Newton step
        pn = -inv(hess) * grad;
        
        % compute q
        
        % compute lagrange multiplier alpha
        
        % check if p and q are very close
        diff = p - q;
        
        % iteration counter
    end
end