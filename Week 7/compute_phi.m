function phi = compute_phi(theta, lambda, rho, mu)
    pi = theta + lambda/rho;
    n = size(theta, 1);
    cons = mu/rho;
    phi = zeros(n, 1);
    
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