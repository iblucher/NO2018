function [ak, fxk, count] = backtrackingls(xk, rho, c, bvec, meas, b, voxel, count)
    ak = 1;
    [fxk, gxk, ~, ~] = tensorfunction(xk, bvec, meas, b, voxel);
    count = count + 1;
    pk = -gxk;
    tk = tensorfunction(xk + ak * pk, bvec, meas, b, voxel);
    count = count + 1;
    wfk = fxk + c * ak * gxk' * pk;
    while (tk > wfk)
        %tensorfunction(xk + ak * pk, bvec, meas, b, voxel)
        %fxk + c * ak * gxk' * pk
        ak = rho * ak;
        tk = tensorfunction(xk + ak * pk, bvec, meas, b, voxel);
        count = count + 1;
        wfk = fxk + c * ak * gxk' * pk;
    end
end