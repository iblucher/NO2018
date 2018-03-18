% this script runs the rosenbrock function plotter on an instance going
% from -1 to 2 with an interval of 0.1 

%Notice a vector is defined this is good to remember
%notice also the ' after the square brackets which transpose the vector so
%we have column vectors 
x = [-1.5:0.05:1.5]'

y = [-1.5:0.05:1.5]'

value = rose(x,y);
% plot the matrix as a surface
surf(x,y,value);

% I call the functions with the global minimum as input expecting a zero
% vector and a positive definite matrix respectively
rosegrad(1,1), rosegrad(0,0), rosegrad(-1,-1)

rosehess(1,1), rosehess(0,0), rosehess(-1,-1)
a=sprintf('%d ', rosehess(1,1));
b=sprintf('%d ', rosehess(0,0));
c=sprintf('%d ', rosehess(-1,-1));

fprintf('rosehess(1,1) = [%s]\nrosehess(0,0) = [%s]\nrosehess(-1,-1) = [%s]', a, b, c);
% try other inputs to test if the result makes sense