%rosenbrock function . This function should fill a matrix (value) with 
% values for the rosenbrock function the input vectors x and y are just the
% x and y values along the axes. your job is to make a nested for loop 
%(or something smarter if you are a matlab-wiz)which fills in all the values  

function value = rose(x,y)

%assume we get two columnvectors as input

X = size(x);
Y = size(y);

value = zeros(X(1),Y(1)); % initialization of the return value 
%fill in all the values of the value matrix with the corresponding values
%of the rosenbrock function for the given point

for i = 1:X(1)
    for j = 1:Y(1)
        value(i, j) = (1 - x(i).^2) + 100 .* ((y(j) - x(i).^2).^2);
    end 
end

end
