start = [1e-4, 10^(-3.5), 1e-3, 10^(-2.5), 1e-2, 10^(-1.5), 1e-1, 10^(-0.5), 1, 10^(0.5), 10, 10^(1.5), 100, 10^(2.5), 1000, 10^(3.5), 1e4];
it_total = zeros(size(start,2), 1);
st = zeros(6, size(start, 2));
for i = 1:size(start, 2)
    st(:, i) = start(i) * [1 0 0 1 0 1]';
end

cnt = zeros(size(start, 2));
for s = 1:size(start, 2)
    [x, i, ngrad, count] = lm(st(:, s), meas, bvec, b, 1);
    it_total(s) = i(end);
    cnt(s) = count;
    
    %plot(i, log(ngrad));
    %xlabel('Number of iterations');
    %ylabel('Norm of gradient $\Vert \nabla f \Vert$', 'Interpreter', 'latex');
    %xlim([0 50]);
    %ylim([-20 20]);
    %hold on;
end

cnt


%hold off;



