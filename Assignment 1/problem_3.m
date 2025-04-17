clc;

A = [1 2; 3 6; 5 10];

columnspace = A(:,any(rref(A)==1))

nullspace = null(A',"rational")

rowspace = A(any(rref(A')==1),:)

leftnullspace = null(A,"rational")'
