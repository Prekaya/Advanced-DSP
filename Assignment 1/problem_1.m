syms t
clc;
fns = [1,t,t^2,t^3,t^4];
inner_product_version = 1;
GramSchmidt(fns, inner_product_version);

function U = GramSchmidt(V, inner_product_version)
    num_vectors = length(V);
    U = sym(zeros(1,num_vectors));
    for n = 1:num_vectors
        U(n) = V(n);
        for l = 1:n-1
            U(n) = U(n) - polyip(V(n),U(l),inner_product_version)*U(l);
        end
        U(n) = U(n)/sqrt(polyip(U(n),U(n),inner_product_version));
    end
end

function value = polyip(f,g,version) 
%inner product for polynomial functions
syms t
    switch version
        case 1
            value = int(f*g,-1,1);
        case 2
            value = int(f*((1-t^2)^-0.5)*g,-1,1);
        otherwise
            value = int(f*g,-1,1);
    end
end


