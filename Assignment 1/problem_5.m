clc

A = [1 2  3;
     3 1 -1];
b = [1, 2]';

lambda = -(A*A')\b;
x_min = -A'*lambda;