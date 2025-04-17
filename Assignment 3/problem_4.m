fs = 1000;
t = -4:1/fs:4;
size(t)
f0 = 50;
n = 1:8001;
hn = (2./(pi*n)) .* (sin(pi*n/2)).^2;
xt = cos(2*pi*f0*t).*exp(-100*t.^2);
ana_xt = hilbert(xt);
envelope = abs(ana_xt);
plot(t, xt, t, envelope);
xlim([-0.4 0.4])
legend('Amp Mod Signal', 'Signal Envelope');