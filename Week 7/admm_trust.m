function final_theta = admm_trust()
    
    while norm(g) > tol && k < max_iter
        % obtain pk from admm method
        [p, q, alpha] = subproblem(q0, alpha0, mu0, rho, theta, x, y);
        
        % evaluate rho
        
        % calculate new delta and x_k+1 with radius size algorithm
        
        % check if converged
end