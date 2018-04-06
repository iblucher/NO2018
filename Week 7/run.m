[f, dist, iter_num] = admm_trust(q0, alpha0, zeros(21, 1), mu, delta0, delta_max, lambda, x, y);
m = mean(dist, 2);
plot(1:iter_num, log(m));
hold on;
    
[f, dist, iter_num] = admm_trust(q0, alpha0, ones(21, 1), mu, delta0, delta_max, lambda, x, y);
m = mean(dist, 2);
plot(1:iter_num, log(m));
hold on;

for i = 2:49
    
    i
    
    [f, dist, iter_num] = admm_trust(q0, alpha0, max(randn(21 ,1), zeros(21, 1)), mu, delta0, delta_max, lambda, x, y);

    m = mean(dist, 2);

    plot(1:iter_num, log(m));
    hold on;
    
    clear f; 
    clear dist;
    clear iter_num;
    
end

