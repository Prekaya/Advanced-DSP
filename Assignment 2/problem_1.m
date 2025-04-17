clc
A = [1, 2;
     2, 3;
     6, 7];


H = Householder(A);
Q = eye(size(A,1));

for i = 1:size(A,2)
    Q = Q*H(:,:,i);
    A = H(:,:,i)*A;
end

 
function H_array = Householder(A)
    n = size(A,2);
    H_array = zeros(size(A,1),size(A,1),n);
    for i = 1:n
        row_size = size(A,1);
        x = A(:,1);
    
        e = zeros(row_size, 1);
        e(1) = 1;
        v = x + sign(real(x(1)))*norm(x,2)*e;
    
        v_hat = v/norm(v,2);
    
        H = eye(row_size) - 2*(v_hat*v_hat');
        next_A = H*A;
        A = next_A(2:end,2:end);
    
        H_array(:,:,i) = blkdiag(eye(i-1),H);
    end 
end