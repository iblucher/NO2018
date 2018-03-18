function z = verifyH(theta, dataset)
    eps = [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6,1e-7, 1e-8, 1e-9];
    ee = length(eps);
    
    [nl, gradl, hnl] = F(theta, dataset);
    
    d = length(theta);
    z = zeros(size(gradl));
    E = eye(d);
    theta = reshape(theta, [1 3]);
    
    nn = zeros([1 ee]);
    
    for l = 1:ee
        for i = 1:d
            e = E(i,:);
            [ff, gg, hh] = F(theta+eps(l)*e, dataset)
            [f, g, h] = F(theta, dataset)
            b = (gg - g);
            z(i, :) = abs(b/eps(l) - hnl(i, :));
        end
        n = norm(z)/norm(hnl);
        n
        nn(l) = n;
    end
    
    plot(log10(eps), log10(nn));
    ylabel('Log10 of the error');
    xlabel('Log10 of epsilon');
    
end