clc;
t = linspace(-10,10,501)';
fs = 25;
signal = (1 - 5*t.^2).*exp(-(t.^2)/0.25);

freqs = [3.75, 5.25, 6.75, 7.75];
phase = [2.68683, 1.07419, 0.563822, 2.60462];
x = freqs*2*pi.*t + phase;

n_band = sum(cos(x),2);
white_noise = sqrt(0.25)*randn(size(t));


noisy_signal = signal + n_band + white_noise;

noisy_psnr = psnr(noisy_signal);
best_psnr = noisy_psnr;
best_filt = 0;
best_length = 0;
best_h = 0;



for m = 2:200
    h_cov = gen_filt(noisy_signal,signal,m);
    % filtered = conv(noisy_signal,h_cov,'same');
    filtered = filter(h_cov,1,noisy_signal);
    cur_psnr = psnr(filtered);
    if cur_psnr > best_psnr
        
        best_filt = filtered;
        best_psnr = cur_psnr;
        best_length = m;
        best_h = h_cov;
    end
end

% freqz(h_cov)

tiledlayout(2,3);
nexttile([1, 2])
plot(t,noisy_signal)
set(gca,'XMinorTick','on','YMinorTick','on')
title('Noisy Signal')
xlabel('Time (s)')
xlim([-10, 10])
ylim([-5, 5])
grid on

nexttile()
plot(t,signal)
xlabel('Time (s)')
set(gca,'XMinorTick','on','YMinorTick','on')
title('Desired Signal')
xlim([-2, 2])
grid on

nexttile([1 2])
plot(t,best_filt)
set(gca,'XMinorTick','on','YMinorTick','on')
title('Filtered Signal')
xlabel('Time (s)')
xlim([-10, 10])
grid on

function h = gen_filt(noisy_signal,desired_signal,filter_length)
    M = filter_length;
    N = length(noisy_signal);
    
    x = noisy_signal;
    y = desired_signal(M:end);
    A = zeros(N-M+1,M);

    for k = 1:M
        A(:,k) = x(M+1-k:N+1-k,:);
    end
    
    [Q,R] = qr(A);
    h = R\Q'*y;
    h = h;
end

function val = psnr(estimate)
    peak = max(estimate);
    mid_region = 50;
    var_region = [estimate(1:floor(end/2)-mid_region); estimate(floor(end/2)+mid_region)];
    noise_sd = std(estimate);
    val = 20*log10(peak/noise_sd);
end