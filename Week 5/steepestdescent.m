function [x, it, ngrad, count] = steepestdescent(x_0, meas, bvec, b, voxel)
    % initializing variables
    %x_0 = 0.01*x_0;
    rho = 0.5;
    c = 1e-4;
    iter = 1;
    tol = 1e-6;
    max_iter = 1e4;
    alpha = ones(max_iter, 1); 
    ngrad = zeros(max_iter, 1);
    t = zeros(max_iter, 1);
    count = 0;
    
    x = x_0;
    [f, g, ~, ~] = tensorfunction(x, bvec, meas, b, 1);
    count = 1;
    ngrad(iter) = norm(g);

    while norm(g) > tol && iter < max_iter
        tic;
        norm(g)
        iter = iter + 1;
        [alpha(iter), f_obj(iter), count] = backtrackingls(x, rho, c, bvec, meas, b, voxel, count);
        p = -g;
        x = x + alpha(iter) * p;
        [~, g, ~, ~] = tensorfunction(x, bvec, meas, b, voxel);
        count = count + 1;
        ngrad(iter) = norm(g);
        t(iter) = toc;
    end

    alpha = alpha(1:iter);
    ngrad = ngrad(1:iter);
    it = 1:iter;
    t = t(1:iter);
end