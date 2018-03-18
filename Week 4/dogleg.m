% Write a program that implements the dogleg method. Choose B k to be the exact
% Hessian. Apply it to solve Rosenbrock’s function (2.22). Experiment with the update rule
% for the trust region by changing the constants in Algorithm 4.1, or by designing your own
% rules.

function p = dogleg(pb, pu, delta, f, g, h)
    if norm(pb) <= delta
        p = pb;
    elseif norm(pu) >= delta
        p = (-delta)/(norm(g))*g;
    else
        a = norm(pb - pu)^2;
        b = 2*pu'*(pb - pu);
        c = norm(pu)^2 - delta^2;
        
        tau = (-b + sqrt(b^2 - 4*a*c))/(2*a) + 1;
        
        if tau >= 0 && tau < 1
            p = tau * pu;
        elseif tau >= 1 && tau <= 2
            p = pu + (tau - 1) * (pb - pu);
        else
            print('Wrong calculation of tau')
        end
    end
end
