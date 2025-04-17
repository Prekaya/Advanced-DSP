clearvars; clc;

corr_vals = [203.958,141.851,-1.47608,-129.563,-163.402,-95.6894,...
             11.5235,79.9316,74.2180,21.4348,-20.6038,-15.6748,...
             22.2838,46.2569,21.5457,-40.7622,-90.9865,-82.4228,...
             -12.0882,73.6525,113.704,79.2819,-4.20298,-77.2997,...
             -91.8851,-45.6812,20.1072,55.9060,42.1030];

M = length(corr_vals); N = 1001;
w = linspace(-0.5,0.5,N); freqs = w*2*pi;
S_mvd = zeros(M,N);

for m = 1:M
    Rxx  = toeplitz(corr_vals(1:m));
    for n = 1:N
        ek = transpose(exp((0:m-1)*1j*freqs(n)));
        S_mvd(m,n) = real(m/(ctranspose(ek)/Rxx*ek));
    end
end

[X,Y] = meshgrid(w,1:M);

figure;
waterfall(X,Y,S_mvd); title('Spectrum estimation for n lags');
xlabel('Hz'); xlim([0,0.3]);
ylabel('lag'); 

figure;
plot(w,S_mvd(end,:)); title('Spectrum estimation for 29 lags');
xlabel('Hz'); xlim([0,0.3]);