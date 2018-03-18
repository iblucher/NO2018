% dataset generator
x = [ones(50,1) randn([50 2])];

theta = [0.5; 1; -1];
[N, M] = size(x);
y = zeros(50, 1);

for i = 1:N
    v = x(i, :);
    f = v * theta;
    r = (99).*rand(10,1) + 1;
    if(f >= 0)
        y(i) = 1;
    else 
        y(i) = -1;
    end
end

% randomly flip labels with some probability
%rng(0, 'twister');
%a = 1;
%b = 100;

%for i = 1:N
    %r = (b - a) .* rand + 1;
    %if r <= 20
        %y(i) = (-1) * y(i);
    %end
%end

dataset = [x y];
dataset = dataset(:, 2:end);

%verify(theta, dataset)
verifyH(theta, dataset)
%F(theta, dataset);

%fplot(@(x) x + 0.5);
%hold on;
%for i = 1:N
    %if dataset(i, end) > 0
        %scatter(dataset(i, 1), dataset(i, 2), 25, 'red', 'filled');
        %hold on;
    %else
        %scatter(random(i, 1), random(i, 2), 25, 'blue', 'filled');
        %hold on;
    %end
%end
