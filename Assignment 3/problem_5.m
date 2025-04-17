clc;
fs = 1;
N = 1024;
dt = 1;
n = 0:1:N-1;
f0 = 0.1;
b = 0.175/(N-1);
sr = cos(2*pi*(f0 + 0.5.*n*b).*n);

[P, freqs, tout] = wigner(sr, fs);
imagesc(tout, freqs, P)
axis xy
colorbar
xlabel('Time')
ylabel('Frequency')
title('Wigner Implementation')

function [P, freqs, t] = wigner(S,fs)
    L = 2*ceil(length(S)/2);
    P = zeros(L,2*L);
    N = linspace(0,L,L);
    Nq = linspace(0,L,2*L);
    S = interp1(N,S,Nq,'linear');
    freqs = linspace(0,fs/2,L);
    dt = 1/(2*fs);
    t = [0:2*L-1]*fs/2;
    
    
    for n = 1:length(t)
        m = [-(n-1):(n-1)];
        del = abs(m) + n > length(t);
        m(del) = [];
        ind1 = n + m;
        ind2 = n - m;
        mult = S(ind1).*conj(S(ind2)); 
        expmult = -4*1i*pi*dt.*m;
        for f = 1:length(freqs)
            P(f, n) = 2*dt*sum(mult.*exp(freqs(f).*expmult));
        end
    end

    P = real(P);
    freqs = freqs';
    t = t';
end