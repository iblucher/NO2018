function drawtensor(A, n)
    % Draw an ellipsoid determined by symmetric positive definite 
    % matrix A as set of solutions of x^T A^{-1} x = 1.
    % n  is an integer which controls grid spacing.
    %
    % Francois Lauze, University of Copenhagen
    % February March 2018.
    %
    
    [R, D] = eig(A);
    D = sqrt(diag(D));
    [X, Y, Z] = ellipsoid(0, 0, 0, D(1), D(2), D(3), n);
   
    x = zeros(size(X));
    y = zeros(size(Y));
    z = zeros(size(Z));
    
    for i = 1 : n + 1
        F = R*[X(i,:); Y(i, :); Z(i, :)];
        x(i,:) = F(1, :);
        y(i,:) = F(2, :);
        z(i,:) = F(3, :);
    end
    figure;
    surf(x, y, z, 'FaceAlpha', 0.1), axis equal;
    hold on
    
    Q = R*diag(D);
    quiver3([0 0 0], [0 0 0], [0 0 0], Q(1,:), Q(2,:), Q(3,:), 'Color', [0.55,0,0], 'LineWidth', 2.5);
    quiver3([0 0 0], [0 0 0], [0 0 0], R(1,:), R(2,:), R(3,:), 'Color', [0,0,0], 'LineWidth', 3.5);
    xlabel('x axis');
    ylabel('y axis');
    zlabel('z axis');
   
    
end