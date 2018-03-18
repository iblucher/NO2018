function s = gendata(D, b, s0, bvecs)
   % Generate pseudodata for DTI fitting problem.
   % D is a 3x3 symmetric positive definite matrix
   % b is a positive double
   % s0 is a positive double
   % bvec is a (3,n) array of direction vectors
   % example
   % D = [3 2 1; 
   %      2 5 2; 
   %      1 2 6]
   % b = 2
   % s0 = 20
   % bvec given in dwidata.mat (and transposed)
   
   
   s = s0*exp(-b*diag(bvecs'*D*bvecs));
   % You may want to comment this line to generate noise-free results.
   s = s + random('rician',0.01, 0.001, size(s));
end