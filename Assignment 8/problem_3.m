clc;
clearvars;
mfdata = readtable('mfdata.txt');
mfsigRv = readtable('mfsigRv.txt');

t = mfdata{:,1};
z = mfdata{:,2};
s = mfsigRv{:,1};
r = mfsigRv{:,2};

R = toeplitz(r); % Build R matrix
S_tr = flip(s); % Time reverse signal

h_mf = R\S_tr; % Solve for matched filter

h_mf = normalize(h_mf,'norm',2); % Normalize matched filter
h_naive = normalize(S_tr,'norm',2); % Normalize naive filter

out_mf = conv(z,h_mf,'same'); % Matched filter output
out_naive = conv(z,h_naive,'same'); % Naive filter output

snr_mf = get_snr(out_mf); % Matched filter SNR
snr_naive = get_snr(out_naive);  % Naive filter SNR

hold on
plot(t(1:length(out_naive)),out_naive)
plot(t(1:length(out_mf)),out_mf)
legend(sprintf('Naive Filter Output, SNR=%.1f',snr_naive),sprintf('Matched Filter Output, SNR=%.1f',snr_mf),'Location','southoutside')
title('Filter Outputs')
xlim([-1 1])
xlabel('Time (s)')
hold off

function snr = get_snr(signal)
    mid = 21;
    half = (length(signal) - mid)/2;
    var_signal = var([signal(1:half);signal(end-half+1:end)]);
    peak_sqr = max(signal(half+1:half+mid))^2;
    snr = 10*log10(peak_sqr/var_signal);
end