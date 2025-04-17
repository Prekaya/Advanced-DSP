clc
% Part A
e = 0.1;

A = [1+2*e, 1-2*e; 2-e, 2+e];
b = [1; 2];
condition_number(A)

X = A\b

% Part B
e = 0.1;

A = [1+2*e, 1-2*e; 2-e, 2+e];
b = [1.05; 2];
condition_number(A)

X = A\b

% Part B
e = 0.001;

A = [1+2*e, 1-2*e; 2-e, 2+e];
b = [1.05; 2];
condition_number(A)

X = A\b


function value = condition_number(A)
    S = svd(A);
    value = S(1)/S(end);
end