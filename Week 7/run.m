q0 = zeros(42, 1);
alpha0 = zeros(42, 1);
mu = 1;
delta0 = 1;
delta_max = 10;
lambda = 1;
[x, y] = gen_data(10, 20);
num_of_iter = zeros(30, 1);

[f, dist, iter_num] = admm_trust(q0, alpha0, zeros(21, 1), mu, delta0, delta_max, lambda, x, y);
plot(1:iter_num, dist);
num_of_iter(1) = iter_num;
hold on;

[f, dist, iter_num] = admm_trust(q0, alpha0, ones(21, 1), mu, delta0, delta_max, lambda, x, y);
plot(1:iter_num, dist);
num_of_iter(end) = iter_num;
hold on;

for i = 2:29
    
    i    

    [f, dist, iter_num] = admm_trust(q0, alpha0, max(randn(21, 1), zeros(21, 1)), mu, delta0, delta_max, lambda, x, y);


    num_of_iter(i) = iter_num;
    plot(1:iter_num, dist);
    hold on;
    
    xlabel('Number of iterations');
    ylabel('$ \Vert p_{k+1} - p_k \Vert$', 'Interpreter', 'latex');

end

mean_iter = mean(num_of_iter, 1);
median_iter = median(num_of_iter, 1);
std_iter = std(num_of_iter, 1);


