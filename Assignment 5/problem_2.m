clc; clearvars;
I = double(imread('parrotsBW.jpg'));
mu = mean(I,'all');
z = I - mu;

R_zz = z*z';

[eig_vec, eig_val] = eig(R_zz);

[d,ind] = sort(diag(eig_val));
W = eig_vec(:,ind);

k_values = [130, 230, 245, 252];

for k = k_values
    Wk = W;
    Wk(:,1:k) = 0;
    zk = Wk*(Wk'*z) + mu;
    
    figure
    imshow(uint8(zk));
    title(sprintf('Compression with K = %d', k));
    filename = sprintf('image%d.png', k);
    exportgraphics(gcf,filename)
    difference = uint8(abs(I - zk));

    figure
    imshow(difference);
    title(sprintf('Difference with K = %d', k));
    filename = sprintf('diff%d.png', k);
    exportgraphics(gcf,filename)
end