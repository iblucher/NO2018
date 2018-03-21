function [F, g, h] = compute_function(theta)
    % generate dataset (x and y)
    
    
   [N, M] = size(x);
   M = M + 1;
   e = length(theta);
   
   % calculate F(theta) for given datset
   F = 0;
   for i = 1:N
       F = F + log(1 + exp(-y(i) * x(i, :) * theta'));
   end
   
   % compute gradient of F
   g = zeros(1, e);
   for j = 1:M
       res = 0
       for i = 1:N
            f = x(i, :) * theta;
            a = -y(i)/(exp(y(i) .* f) + 1);
            res = res + a .* x(i, j);
        end
        g(j) = res;
    end
       
   % compute Hessian of F
    h = zeros(e, e);
    for i = 1:M
        for j = 1:M
            res = 0;
            for s = 1:N
                f = x(s, :) * theta;
                a = (exp(y(s) .* f)) ./ ((exp(y(s) .* f) + 1).^ 2);
                res = res + y(s).^2 * a * x(s, i) * x(s, j);
            end
            h(i, j) = res;
        end
    end
end