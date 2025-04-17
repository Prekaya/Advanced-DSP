clc
S = [3.5,  4.0, 2.0;
     4.0, 18.5, 8.0;
     2.0,  8.0, 6.5];

L = Cholesky(S);
function C = Cholesky(C)

    if size(C,1) == 1
        C = sqrt(C(1,1));
    else
        sqrt_a = sqrt(C(1,1));
        C(1,1) = sqrt_a;
        C(1,2:end) = 0;
        l_21 = C(2:end,1)/sqrt_a;
        C(2:end,1) = l_21;
        C_22 = C(2:end,2:end) - l_21*l_21';
        C(2:end,2:end) = Cholesky(C_22);
    end

end