function H = fhessian_component(u)
    % u is a lewngth 3 vector, the function returns a 6x6 matrix
    % described in the dwi.pdf notes.
    H = zeros(6);
    
    H(1,:) = [u(1)^4, 2*u(1)^3*u(2), 2*u(1)^3*u(3), u(1)^2*u(2)^2, 2*u(1)^2*u(2)*u(3), u(1)^2*u(3)^2];
    H(2:6,1) = H(1,2:6);
    H(2,2:end) = [4*u(1)^2*u(2)^2,  4*u(1)^2*u(2)*u(3), 2*u(1)*u(2)^3, 4*u(1)*u(2)^2*u(3), 2*u(1)*u(2)*u(3)^2];
    H(3:end, 2) = H(2,3:end);
    H(3,3:end) = [4*u(1)^2*u(3)^2, 2*u(1)*u(2)^2*u(3),  4*u(1)*u(2)*u(3)^2, 2*u(1)*u(3)^3];
    H(4:end,3) = H(3,4:end);
    H(4,4:end) = [u(2)^4, 2*u(2)^3*u(3), u(2)^2*u(3)^2];
    H(5:end,4) = H(4,5:end);
    H(5,5:end) = [4*u(2)^2*u(3)^2, 2*u(2)*u(3)^3];
    H(6,5) = H(5,6);
    H(6,6) = u(3)^4;
end

    