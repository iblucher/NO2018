mu = 1;
rho = [1e-1; 1; 10; 100; 1000; 1e4];
[x, y] = gen_data(10, 20);
phi0 = zeros(21, 1);
lambda0 = zeros(21, 1);

num_of_iter = zeros(size(rho, 1), 1);
time = zeros(size(rho, 1), 1);


for i = 1:size(rho, 1)
    
    i    
    
    tic;
    [final_theta, dist, k] = admm(ones(21, 1), phi0, lambda0, rho(i ,1), mu, x, y);
    time(i) = toc;

    num_of_iter(i) = k;
    
end

figure
ax1 = subplot(2,1,1);
plot(ax1,log(rho),num_of_iter);
xlabel(ax1, 'Log of value of $\rho$', 'Interpreter', 'latex');
ylabel(ax1, 'Number of iterations');

ax2 = subplot(2,1,2);
plot(ax2, log(rho), time);
xlabel(ax2, 'Log of value of $\rho$', 'Interpreter', 'latex');
ylabel(ax2, 'Run time in seconds');