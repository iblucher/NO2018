function [F, g, h] = compute_function(theta, x, y)
    
   [N, M] = size(x);
   e = length(theta);
   
   % calculate F(theta) for given datset
   F = 0;
   for i = 1:N
       F = F + log(1 + exp(-y(i) * x(i, :) * theta));
   end
   
   % compute gradient of F
   f = x * theta;
   a = y' * f;
   ex = exp(a);
   b = 1 + ex;
   b = 1./b;
   c = -b .* y;
   g = x' * c;
       
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