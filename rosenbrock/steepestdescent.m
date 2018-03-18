% Program the steepest descent and Newton algorithms using the backtracking line
% search, Algorithm 3.1. Use them to minimize the Rosenbrock function (2.22). Set the initial
% step length α 0  1 and print the step length used by each method at each iteration. First try
% the initial point x 0  (1.2, 1.2) T and then the more difficult starting point x 0  (−1.2, 1) T .

% initializing variables
x_0 = [-1.2; 1];
rho = 0.5;
c = 0.5;
iter = 1;
tol = 1e-8;
max_iter = 1e6;
f_obj = zeros(max_iter, 1);
alpha = ones(max_iter, 1);
dist = zeros(max_iter, 1);

x = x_0;
f_obj(iter) = rosenew(x_0);
while norm(rosegrad(x)) > tol && iter < max_iter
    dist(iter) = norm(x - [1; 1]);
    iter = iter + 1;
    p = - rosegrad(x);
    [alpha(iter), f_obj(iter)] = backtrackingls(x, p, rho, c);
    x = x + alpha(iter) * p;
end
f_obj = f_obj(1:iter);
alpha = alpha(1:iter);
dist = dist(1:iter);
alpha
iter
x

i = 1:iter;

plot(i, dist);
axis([0 2000 0 3]);
hold on;