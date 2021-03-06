function [f_theta, g_theta, h_theta] = compute_theta(theta0, phi, lambda, rho, x, y)
    e = length(theta0);
    theta = theta0;
    [F, g, h] = compute_function(theta, x, y);
    
    f_theta = F + rho/2 * norm(theta - (phi - lambda/rho))^2;
    g_theta = g + rho * (theta - (phi - lambda/rho));
    h_theta = h + rho * eye(e);
   
end