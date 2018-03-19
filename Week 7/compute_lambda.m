function lambda = compute_lambda(lambda0, theta, phi, rho)
    lambda = lambda0 + rho * (theta - phi);
end