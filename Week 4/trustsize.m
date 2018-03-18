function [r,x]=trustsize(r0,pk,xk,rho,n,m,tol)

    if rho < 1/4
        r= r0/4;
    else
        if rho > 3/4 && abs(norm(pk) - r0) < tol
            r=min(2*r0,m);
        else 
            r=r0;
        end
    end
    if rho>n
        x=xk+pk;
    else
        x=xk;
    end
end