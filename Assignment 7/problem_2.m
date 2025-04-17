clc;
clearvars;
w = [0.1, 0.2].*2*pi;
A = [1, 2];
M = (1:8)';

% w = [0.1, 0.15, 0.2]*2*pi;
% A = [4, 5, 6];
% M = (1:7)';

K = length(A);

S = exp((M-1)*1i.*w);
P = diag(A.^2);

Rss = S*P*ctranspose(S);
Var = [0 1 4];
n = 1001;
Hz = linspace(-0.5,0.5,n);
wspan = Hz*2*pi;
ew = exp((M-1)*1i.*wspan);
for v = Var
    Rvv = v*eye(M(end));
    Rxx = Rss + Rvv;

    % Get eigenvalues and vectors
    [eigVec,eigVal] = eig(Rxx,"vector",'balance');
    [eigVal, ind] = sort(eigVal,'descend');
    testVec = eigVec;
    eigVec = eigVec(:, ind);
    eigVec = eigVec(:,K+1:length(M));
    Smusic = (sum(abs(ew'*eigVec).^2,2)).^-1;
    maxS = max(Smusic,[],'all');
    Smusic = Smusic/maxS;
    % figure;
    % plot( wspan/pi,5*log10(Smusic))
    % xlabel 'Normalized Frequency', ylabel 'dB'
    % title 'Pseudospectrum Estimate via MUSIC', grid on
    A = [eye(K+1,1),exp(1i*(0:K)'.*w)]
    R = Rxx(1:K+1,1)

    P = A\R
    % varout = result(1);
    %  = result(2:end)
end

    

