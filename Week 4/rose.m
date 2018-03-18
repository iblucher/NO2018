function [f, g, h] = rose(x)
    f = rosenew(x);
    g = rosegrad(x);
    h = rosehess(x);
end