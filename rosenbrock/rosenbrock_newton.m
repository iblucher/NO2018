function rosenbrock_newton()
% Program the steepest descent and Newton algorithms using the backtracking
% line search, Algorithm 3.1. Use them to minimize the Rosenbrock function
% (2.22). Set the initial step length = 1 and print the step length used
% by each method at each iteration. First try the initial point
% x0 = (1.2, 1.2)T and then the more difficult starting point x0 = (1.2, 1)T
alpha_max = 1;
rho = 0.5;
c = 0.5;

x_0 = [1.2; 1.2];
[x_p, f_obj, alpha, iter] =  backtracking_min(x_0, 'steepest descent', ...
                                              alpha_max, rho, c);
plot_results(x_p, f_obj, alpha, iter, 'steepest descent', x_0);
[x_p, f_obj, alpha, iter] =  backtracking_min(x_0, 'newton', alpha_max, rho, c);
plot_results(x_p, f_obj, alpha, iter, 'newton', x_0);

x_0 = [1.2; 1];
[x_p, f_obj, alpha, iter] =  backtracking_min(x_0, 'steepest descent', ...
                                              alpha_max, rho, c);
plot_results(x_p, f_obj, alpha, iter, 'steepest descent', x_0);
[x_p, f_obj, alpha, iter] =  backtracking_min(x_0, 'newton', alpha_max, rho, c);
plot_results(x_p, f_obj, alpha, iter, 'newton', x_0);
end

function [x, f_obj, alpha, iter] = backtracking_min(x_0, method, ...
                                                      alpha_max, rho, c)
iter = 1;
tol = 1e-6;
max_iter = 1e6;
f_obj = zeros(max_iter, 1);
alpha = alpha_max * ones(max_iter, 1);
alpha(1) = 0;

x = x_0;
f_obj(iter) = rb_function(x);
while norm(rb_gradient(x)) > tol && iter < max_iter
  iter = iter + 1;
  p = step_dir(x, method);
  [alpha(iter), f_obj(iter)] = step_length(x, p, alpha(iter), rho, c);
  x = x + alpha(iter) * p;
end
f_obj = f_obj(1:iter);
alpha = alpha(1:iter);
end

function p = step_dir(x_k, method)
% Return a unit direction of search
if strcmp(method, 'newton')
  p = - rb_hessian(x_k)^-1 * rb_gradient(x_k);
else
  p = - rb_gradient(x_k);
end
p = p / norm(p);
end

function [alpha, f_x_k] = step_length(x_k, p_k, alpha_max, rho, c)
% Return the step length based on first Wolfe condition
alpha = alpha_max;
f_x_k = rb_function(x_k);
while (rb_function(x_k + alpha * p_k) > ...
      f_x_k + c * alpha * rb_gradient(x_k)' * p_k)
  alpha = rho * alpha;
end
end

% Visualize iteration
function plot_results(x_p, f_obj, alpha, iter, method, x_0)
figure;
subplot(1, 2, 1);
plot(1:iter, f_obj);
title(['Min Rosenbrock funct with ', method])
ylabel('f(x)');
xlabel('Iters');
subplot(1, 2, 2);
plot(1:iter, alpha)
title(['x_0 = ', mat2str(x_0', 3), ', x^* = ', mat2str(x_p', 3)]);
ylabel('alpha');
xlabel('Iters');
end

% Function to minimize, its gradient and hessian

function f = rb_function(x)
f = 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
end

function gf = rb_gradient(x)
gf = [2 * x(1) - 400 * x(1) * (- x(1)^2 + x(2)) - 2;
      200 * (x(2) - x(1)^2)];
end

function hf = rb_hessian(x)
hf = [2 + 1200 * x(1)^2 - 400 * x(2), -400*x(1);
      -400 * x(1), 200];
end