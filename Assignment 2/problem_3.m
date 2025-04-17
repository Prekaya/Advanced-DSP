clc;

% x1 = zeros(1,10);
% y1 = zeros(1,10);
% 
% x2 = zeros(1,9);
% y2 = zeros(1,9);

for i = 1:11

    n = i+1;
    A = hilb(n);
    
    x1(i) = n;
    y1(i) = condition_number(A);
    
end

for i = 1:9

    n = i+1;
    C = cosine_mat(n);

    x2(i) = n;
    y2(i) = condition_number(C);

end

figure()
plot(x1,y1)
xlabel('N')
ylabel('Condition Number')
axis padded
title('Hilbert Matrix Condition Number')

figure()
plot(x2,y2)
xlabel('N')
ylabel('Condition Number')
axis padded
title('Cosine Matrix Condition Number')

function value = condition_number(A)
    S = svd(A);
    value = S(1)/S(end);
end

function mat = cosine_mat(N)
    w0 = 4000*pi; delta_w = 25*pi; delta_t = 1/5000;
    mat = zeros(N,N);
    for i = 1:N
        for j = 1:N
            k = j-1;
            n = i-1;
            mat(i,j) = cos((w0 - k*delta_w)*n*delta_t);
        end
    end
end