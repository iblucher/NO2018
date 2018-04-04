function[r, x] = radiussize(rho, delta, delta_max, x_k, p_k, eta, tol)
    if rho < 1/4
        r = delta/4;
    else
        if rho > 3/4 && abs(norm(p_k, inf) - delta) < tol
            r = min(2*delta, delta_max);
        else
            r = delta;
        end
    end
    
    if rho > eta
        x = x_k + p_k;
    else
        x = x_k;
    end
     
end