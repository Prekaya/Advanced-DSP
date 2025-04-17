clc; clearvars;
set(groot,'defaulttextinterpreter','latex');  
set(groot, 'defaultAxesTickLabelInterpreter','latex');  
set(groot, 'defaultLegendInterpreter','latex');

R_xx = [2, 0.9;
        0.9, 11];

L = Cholesky(R_xx);

v = randn(2,10000);

x = L*v;

[eig_vec, eig_val] = eig(R_xx);


figure;
tiledlayout

nexttile
axis equal
hold on
scatter(x(1,:), x(2,:),'.');
origin = zeros(1,size(eig_vec,2)); 
plot([origin; eig_vec(1,:)],[origin; eig_vec(2,:)],'LineWidth',1.5,'Color','Red'); 
xlabel('$x_1$'); ylabel('$x_2$');
title('Principle Vectors of $R_{xx}$')
hold off
 
R_xx_est = x*x';
[eig_vec_est, eig_val_est] = eig(R_xx_est);

nexttile
axis equal
hold on
scatter(x(1,:), x(2,:),'.');
origin = zeros(1,size(eig_vec_est,2)); 
plot([origin; eig_vec_est(1,:)],[origin; eig_vec_est(2,:)],'LineWidth',1.5,'Color','Red'); 
xlabel('$x_1$'); ylabel('$x_2$');
title('Principle Vectors of $\hat{R}_{xx}$')
hold off

[d,ind] = sort(diag(eig_val),"descend");
W = eig_vec(:,ind);
y = W.'*x;

figure
axis("equal")
hold on
scatter(y(1,:), y(2,:),'.');
xlabel('$x_1$'); ylabel('$x_2$');
title('Transformed Data');
hold off

w1 = W(:,1);
y1 = w1'*x;

figure
axis("equal")
hold on
plot(y1,'.')
title('Compressed Transformed Data');
xlabel('index'); ylabel('$y_1$');
hold off

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