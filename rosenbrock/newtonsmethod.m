% initializing variables
x_0 = [-1.2; 1];
rho = 0.5;
c = 0.5;
iter = 1;
tol = 1e-6;
max_iter = 1e5;
f_obj = zeros(max_iter, 1);
alpha = ones(max_iter, 1);
dist = zeros(max_iter, 1);

x = x_0;
f_obj(iter) = rosenew(x_0);
while norm(rosegrad(x)) > tol && iter < max_iter
    dist(iter) = norm(x - [1; 1]);
    iter = iter + 1;
    p = - rosehess(x)^-1 * rosegrad(x);
    % chek if hessian is positive definite, if not, do a steepest descent
    % step direction
    e = eig(rosehess(x), 'matrix');
    if det(e) < 0
        p = - rosegrad(x);
        print('Hessian is not positive definite');
    end
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

plot(i, log(dist), 'r');
axis([0 2000 0 3]);
xlabel('Number of iterations');
ylabel('Euclidean norm of x_k - x*');
legend('Steepest descent', "Newton's method");