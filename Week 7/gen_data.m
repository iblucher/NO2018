function [x, y] = gen_data(r, c)
    x = [ones(r, 1) randn(r, c)];
    %theta = ones(c + 1, 1);
    theta = [0.5; 10; 3; 1];
    theta = [theta; zeros(17, 1)];
    epsilon = randn(r, 1);
    sigma = 10; % noise
    y = sign(x * theta + sigma * epsilon);
end
   