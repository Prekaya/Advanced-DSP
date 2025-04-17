clc;
N1 = 50;
N2 = 100;
N3 = 200;

ws = 0.125;
wp = 0.1;

ws_un = ws*2*pi;
wp_un = wp*2*pi;
a = 0.5;
[t1,r1] = eigenfilter(N1,ws_un,wp_un,a);
[t2,r2] = eigenfilter(N2,ws_un,wp_un,a);
[t3,r3] = eigenfilter(N3,ws_un,wp_un,a);

[h1,w1] = freqz(t1,1,4096);
[h2,w2] = freqz(t2,1,4096);
[h3,w3] = freqz(t3,1,4096);

hold on
resp1 = plot(w1/(2*pi),20*log10(abs(h1)));
resp2 = plot(w2/(2*pi),20*log10(abs(h2)));
resp3 = plot(w3/(2*pi),20*log10(abs(h3)));
hold off
xlim([0.08,0.15])
ylim([-120,5])
legend([resp1, resp2, resp3], 'N=50','N=100','N=200','AutoUpdate','off');
label = {sprintf('Stop Band\n%.3f',ws),sprintf('Pass Band\n%.3f',wp)};
xline([ws,wp],'--',label);
xlabel('Normalized Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on


function [filt_coeff,r] = eigenfilter(N,ws,wp,a)
    l = N/2 + 1;
    
    R_out =  zeros(l,l);
    
    for i = 0:l-1
        for j = 0:i
            if i == 0 && j == 0
                Rs = pi - ws;
                Rp = 0;
            elseif i == 0
                Rs = (sin(j*pi) - sin(j*ws))/j;
                Rp = 0;
            elseif j == 0
                Rs = (sin(i*pi) - sin(i*ws))/i;
                Rp = 0;
            elseif i == j
                Rs = (sin(2*pi*i) + 2*pi*i - sin(2*i*ws) - 2*i*ws)/(4*i);
                Rp = wp - sin(j*wp)/j - sin(i*wp)/i + (sin(2*i*wp) + 2*i*wp)/(4*i);
            else
                Rs = sin((i+j)*pi)/(2*(i+j)) + sin((i-j)*pi)/(2*(i-j)) - sin((i+j)*ws)/(2*(i+j)) - sin((i-j)*ws)/(2*(i-j));
                Rp = wp- sin(j*wp)/j - sin(i*wp)/i + sin((i+j)*wp)/(2*(i+j)) + sin((i-j)*wp)/(2*(i-j));
            end

            R_out(i+1,j+1) = a*Rp + (1-a)*Rs;
            R_out(j+1,i+1) = a*Rp + (1-a)*Rs;
        end
    end
    [V,D] = eig(R_out,'vector');
    [~,I] = min(D);
    div = [1, 2*ones(1,l-1)];
    h_tilde = normalize(V(:,I)','norm');
    H_half_rev = h_tilde./div;
    filt_coeff = [H_half_rev(end:-1:2), H_half_rev(1:end)];
    filt_coeff = filt_coeff./sum(filt_coeff);
    r = R_out;
end