function D = lstf(s, s0, b, bvec)
    n = length(s);
    a = -log(s/s0)/b;
    J = zeros(n,6);
    for i = 1 : n
        J(i,:) = mat2vec(bvec(:,i)*bvec(:,i)');
    end
    Ja = J'*a;
    H = J'*J;
    d = H\Ja;
    D = vec2mat(d);
end       
        
function U = mat2vec(M)
    U = [M(1,1) 2*M(1,2) 2*M(1,3) M(2,2), 2*M(2,3), M(3,3)];
end
            
function M= vec2mat(U)
   M = [U(1) U(2) U(3); 
         U(2) U(4) U(5);
         U(3) U(5) U(6)];
end     