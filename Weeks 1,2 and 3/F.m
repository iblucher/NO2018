function [nl, gnl, hnl] = F(theta, dataset)
    %F -- Negative log-probability of a dataset
    %input:
    %   theta: the vector specifying the linear model, length d+1,
    %       as (theta_0, theta_1,...,theta_d) where theta_0 is the 
    %       constant term (intercept) of the linear model,
    %
    %   dataset: matrix of data values: (n,d+1) where the last column 
    %       contains label values
    %
    %output:
    %   nl: the neg-log-probability of dataset,
    %   gnl: the gradient of the function wrt to theta: (d+1)-array
    %   hnl: the Hessian of the function with respect to theta, a
    %       (d+1,d+1) matrix
    
    % Note I am using the so called "Matlab modern function style"
    
    
    % May want to separate vector data from associated labels
    
    e = length(theta);
    d = e - 1;
    [N,M] = size(dataset);
    theta = reshape(theta, [3, 1]);
    if M ~= e
        error('dimensions mismatch');
    end
    % on one hand remove the labels from the dataset,
    % on the other hand, add a constant 1. first column.
    
    y = dataset(:,end);
    x = [ones(N,1) dataset(:,1:end-1)];
    
    % code Compute nl
    nl = 0;
    for i=1:N
        v = x(i, :);
        f = v * theta;
        nl = nl + log(1 + exp(-y(i) .* f));
    end
    L_theta = nl;
    
    % complute the gradient of nl
    gnl = zeros(1, e);
    for j = 1:M
        res = 0;
        for i = 1:N
            f = x(i, :) * theta;
            a = -y(i)/(exp(y(i) .* f) + 1);
            res = res + a .* x(i, j);
        end
        gnl(j) = res;
    end
    gnl
    
    % compute the Hessian of nl
    hnl = zeros(e, e);
    for i = 1:M
        for j = 1:M
            res = 0;
            for s = 1:N
                f = x(s, :) * theta;
                a = (exp(y(s) .* f)) ./ ((exp(y(s) .* f) + 1).^ 2);
                res = res + y(s).^2 * a * x(s, i) * x(s, j);
            end
            hnl(i, j) = res;
        end
    end
end