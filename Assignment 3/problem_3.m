clc;clearvars;
z_0 = -1 + 1i;
p_0 = -0.5 + 2i;
k_0 = 1.0;

z_1 = 0.75*exp(0.2i*pi);
p_1 = 0.5*exp(0.3i*pi);
k_1 = 1.0;

sys_0 = zpk(z_0, p_0, k_0);
sys_1 = zpk(z_1, p_1, k_1);

    
w0 = -20:0.001:20;
[mag0, phase0, wout] = bode(sys_0,w0);
phase0 = deg2rad(reshape(phase0,[],1));
mag0 = reshape(mag0,[],1);
hr_0 = -imag(hilbert(log(mag0)));



figure;
plot(wout, phase0, 'b', wout, hr_0, 'r');
xlim([-5, 5]);
legend('phase', 'hilbert phase')
ylabel('phase')
xlabel('\omega')
title('continuous hilbert phase')

w1 = -2*pi:0.001:2*pi;
[mag1, phase1, wout] = bode(sys_1,w1);
phase1 = deg2rad(reshape(phase1,[],1));
mag1 = reshape(mag1,[],1);
hr_1 = imag(hilbert(log(mag1)));
figure;
plot(wout, phase1, 'b', wout, hr_1, 'r');
xlim([-pi, pi]);
legend('phase', 'hilbert phase')
ylabel('phase')
xlabel('\omega')
title('discrete hilbert phase')
