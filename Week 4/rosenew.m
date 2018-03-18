%rosenbrock function . This function should fill a matrix (value) with 
% values for the rosenbrock function the input vectors x and y are just the
% x and y values along the axes. your job is to make a nested for loop 
%(or something smarter if you are a matlab-wiz)which fills in all the values  

function f = rosenew(x)
f = 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;
end