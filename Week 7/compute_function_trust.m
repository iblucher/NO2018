function [L, gradL, hessL] = compute_function_trust(theta, x, y, lambda)
    % this function calculates the reparametrized version of the logistic
    % regression
    
    % separate theta into w+ and w-
    d = size(theta, 1);
    wplus = nan(d);
    wminus = nan(d);
    for i = 1:d
        if theta(i) >= 0
            wplus(i)= theta(i);
            wminus(i) = 0;
        elseif theta(i) < 0
            wminus = abs(theta(i));
            wplus(i) = 0;
        end
    end
    
    % call logistic regression function
    [f, g, h] = compute_function(theta, x, y);
    
    % compute function value
    s = 0;
    for i = 1:d
        s = wplus(i) - wminus(i);
    end
    L = f + lambda * s;
    
    % compute greadient value
    
    
    % compute hessian value
end