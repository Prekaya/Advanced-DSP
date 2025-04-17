clc;
e = 0.0001;
v1 = [1, e, e]';
v2 = [1, e, 0]';
v3 = [1, 0, e]';
fns = [v1, v2, v3]
out = GramSchmidt(fns)
out2 = GramSchmidt2(fns)

function U = GramSchmidt(V)
    num_vectors = size(V,2);
    U = zeros(size(V));
    for n = 1:num_vectors
        U(:,n) = V(:,n) - sum((V(:,n).'*U(:,1:n-1)).*U(:,1:n-1),2);
        U(:,n) = U(:,n)/norm(U(:,n));

    end
end

function U = GramSchmidt2(V)
    num_vectors = size(V,2);
    U = zeros(size(V));
    for n = 1:num_vectors
        U(:,n) = V(:,n);
        for l = 1:n-1
            U(:,n) = U(:,n) - dot(V(:,n),U(:,l))*U(:,l);
        end
        U(:,n) = U(:,n)/norm(U(:,n));
    end
end