% clc;
% clearvars;
% w = [0.1, 0.2].*2*pi;
% A = [1, 2];
% M = 1:8;

w = [0.1, 0.15, 0.2]*2*pi;
A = [4, 5, 6];
M = (1:7)';
K = length(A);

S = exp((M-1)*1i.*w);
P = diag((A.^2));

Rss = S*P*ctranspose(S);
Var = [9];
n = 1000;
Hz = linspace(-0.5,0.5,n);
wspan = linspace(-2,2,n)*pi;
ew = exp((M-1)*1i.*wspan);
for v = Var
    Rvv = v*eye(M(end));
    Rxx = Rss + Rvv;
    % Rxx = toeplitz(cos(0.1*pi*(0:6))) + 0.1*eye(7);
    % pmusic(Rxx,4,'corr');
    % [Pows,f] = pmusic(Rxx,4,n,'corr','centered');
    
    figure
    pmusic(Rxx,4,n,'corr','centered');
    % plot(f/pi,20*log10(abs(Pows)))
    % xlabel 'Frequency (Hz)', ylabel 'Power (dB)'
% title 'Pseudospectrum Estimate via MUSIC', grid on
end
