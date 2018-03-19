function phi = compute_phi(theta, lambda, rho, mu)
    pi = theta + lambda/rho;
    n = size(theta);
    cons = mu/rho;
    
    % component-wise computation of phi (with closed formula)
    for i = 1:n
        if pi(i) < -cons
            phi(i) = pi(i) + cons;
        elseif pi(i) > cons
            phi(i) = pi(i) - cons;
        else
            phi(i) = 0;
        end
    end
end