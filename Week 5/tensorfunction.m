function [f, g, h, J] = tensorfunction(x, bvec, meas, b, voxel)
    % x is the 6 dimensional vector we use to build D
    % voxel is the voxel index (row index of meas) being used for the computation
    
    % use x to compute D
    D = vec2mat(x);
    
    % compute F(D)
    sumf = 0;
    c = size(meas, 2);
    for j = 2:c
        uj = bvec(j-1, :);
        ujD = uj * D * uj';
        e = exp(-b * ujD);
        sumf = sumf + 0.5*(meas(voxel, j) - meas(voxel, 1) * e)^2;
    end
    f = sumf;
    
    % compute grad F(D)
    sumg = 0;
    for j = 2:c
        uj = bvec(j-1, :);
        ujD = uj * D * uj';
        e = exp(-b * ujD);
        sumg = sumg + ((meas(voxel, j) - meas(voxel, 1) * e) * e * (uj' * uj));
    end
    g = meas(voxel, 1) * b * sumg;
    g = [g(1,1), g(1,2), g(1,3), g(2,2), g(2,3), g(3,3)]';
    
    % compute Hessian approximation J^TJ
    J = zeros(90, 6);
    for j = 2:c
        uj = bvec(j-1, :);
        ujD = uj * D * uj';
        lj = exp(-b * ujD);
        
        J(j - 1, 1) = lj * uj(1)^2;
        J(j - 1, 2) = lj * uj(1) * uj(2);
        J(j - 1, 3) = lj * uj(1) * uj(3);
        J(j - 1, 4) = lj * uj(2)^2;
        J(j - 1, 5) = lj * uj(2) * uj(3);
        J(j - 1, 6) = lj * uj(3)^2;   
    end
    J = meas(voxel, 1) * b * J;
    h = J'*J;
 
end