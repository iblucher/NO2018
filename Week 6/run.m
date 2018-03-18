A = [2 3 -1; 3 0 -1; -8 2 1; -1 2 4; 1 -1 3];
b = [1; 1; 1; 1; 1];

B = A' * A;
c = b' * A;
m = [-100; -100; -100];
M = [100; 100; 100];

st = zeros(3, 100);
it = zeros(1, 100);

for i = 1:100
    x_0 = m(1) + rand(3, 1) * (M(1) - m(1));
    [sol, k, g_norm] = constrained_opt(B, c, m, M, x_0);
    sol
    it(i) = k;
    plot(1:k, log(g_norm));
    hold on;
end
xlabel('Number of iterations');
ylabel('$log(\Vert \nabla q \Vert)$', 'Interpreter', 'latex');

m = mean(it)
me = median(it)
stde = std(it)