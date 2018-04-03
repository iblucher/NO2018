function final_theta = admm_trust()
    
    while norm(g) > tol && k < max_iter
        % obtain pk from admm method
        [p, q, alpha] = subproblem();
        
        % evaluate rho
        
        % calculate new delta and x_k+1 with radius size algorithm
        
        % check if converged
end