function [x, y] = gen_data(r, c)
    x = [ones(r, 1) randn(r, c)];
    theta = ones(c + 1, 1);
    epsilon = randn(r, 1);
    sigma = 1; % noise
    y = sign(x * theta + sigma * epsilon);
end
   