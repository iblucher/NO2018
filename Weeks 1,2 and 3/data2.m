% dataset generator
random = randn([50 2]);
x = [ones(50,1) random];

theta = [0; 1; -1];
[N, M] = size(random);
y = zeros(50, 1);
for i = 1:N
    v = x(i, :);
    f = v * theta;
    if(f >= 0)
        y(i) = 1;
    else 
        y(i) = -1;
    end
end

dataset = [x y];
dataset = dataset(:, 2:end);
F(theta, dataset);

[X,Y]=meshgrid(-5:.2:4, -4:.2:5);
d=size(X,1);
Z=nan(d);
for i = 1:d
    for j= 1:d
        Z(i, j) = F([0.5; X(1, i); Y(j, 1)], dataset);
    end
end
surf(X, Y, Z)

