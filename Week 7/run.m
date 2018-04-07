q0 = zeros(42, 1);
alpha0 = zeros(42, 1);
mu = [1e-4; 1e-3; 1e-2; 1e-1; 1; 10; 100; 1000];
delta0 = 1;
delta_max = 10;
lambda = 1;
[x, y] = gen_data(10, 20);
num_of_iter = zeros(9, 1);
time = zeros(9, 1);

for i = 1:size(mu, 1)
    
    i
    
    tic;
    [f, dist, iter_num] = admm_trust(q0, alpha0, zeros(21, 1), mu(i, 1), delta0, delta_max, lambda, x, y);
    time(i) = toc;

    num_of_iter(i) = iter_num;
    
end

figure
ax1 = subplot(2,1,1);
plot(ax1,log(mu),num_of_iter);
xlabel(ax1, 'Log of value of $\mu$', 'Interpreter', 'latex');
ylabel(ax1, 'Number of iterations');

ax2 = subplot(2,1,2);
plot(ax2, log(mu), time);
xlabel(ax2, 'Log of value of $\mu$', 'Interpreter', 'latex');
ylabel(ax2, 'Run time in seconds');

