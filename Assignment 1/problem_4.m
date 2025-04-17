clc
a1 = [1, 1, 0]';
a2 = [0, 1, 0]';
b = [1, 2, 3]';

A = [a1 a2];

x_hat = (A'*A)\(A'*b);
b_hat = A*x_hat

error = b - b_hat

a1_dot_error = dot(a1,error);
a2_dot_error = dot(a2,error);