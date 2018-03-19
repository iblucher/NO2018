function F = compute_function(x, y, theta)
   F = 0;
   n = size(y);
   
   % calculate F(theta) for given datset
   for i = 1:n
       F = F + log(1 + exp(-y(i) * x(i, :) * theta'));
   end
end