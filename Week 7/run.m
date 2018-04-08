mu = 1;
[x, y] = gen_data(10, 20);
phi0 = zeros(21, 1);
lambda0 = zeros(21, 1);
num_of_iter = zeros(size(lambda, 1), 1);
%time = zeros(size(lambda, 1), 1);

for i = 1:size(lambda, 1)
    
    i    
    
    tic;
    [f, dist, iter_num] = admm_trust(q0, alpha0, max(randn(21, 1), zeros(21, 1)), mu, delta0, delta_max, lambda(i, 1), x, y);
    time(i) = toc;

    num_of_iter(i) = iter_num;
 
end


