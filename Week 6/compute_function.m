function [f, g] = compute_function(B, c, x)
    f = 0.5 * x' * B * x - c * x;
    g = B * x - c';
end
    