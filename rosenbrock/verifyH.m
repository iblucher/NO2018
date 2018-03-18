function z = verifyH(theta, dataset)
    eps = 10^(-9);
    
    [nl, gradl, hnl] = F(theta, dataset);
    
    d = length(theta);
    z = zeros(size(gradl));
    E = eye(d);
    theta = reshape(theta, [1 3]);
    for i = 1:d
        e = E(i,:);
        gradeps = F(theta+eps*e, dataset)(2);
        grad = F(theta, dataset)(2);
        b = (gradeps - grad);
        z(i) = abs(b/eps - hnl(i));
    end
    n = norm(z)/norm(hnl);
    
end