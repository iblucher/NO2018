% the gradient of the rosenbrock function
function gf = rosegrad(x)

%return a vector of 2 elements which gives the derivative of the rosenbrock
%with regard to x and y respectively
% I have supplied a template where each element is just set to zero
gf = [2 * x(1) - 400 * x(1) * (- x(1)^2 + x(2)) - 2;
      200 * (x(2) - x(1)^2)];
end