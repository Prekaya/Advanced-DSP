clearvars; clc; 
opts = bodeoptions;
opts.FreqScale = 'linear';
opts.MagVisible = 'off';
opts.PhaseMatching = 'on';
opts.PhaseMatchingFreq = 1; 
opts.PhaseMatchingValue = 0;
z_0 = -1 + 1i;
p_0 = -0.5 + 2i;
k_0 = 1.0;

z_1 = 1 + 1i;
p_1 = -0.5 + 2i;
k_1 = 1.0;

sys_0 =  zpk(z_0, p_0, k_0);
sys_1 =  zpk(z_1, p_1, k_1);
[num0,den0] = zp2tf(z_0, p_0, k_0);
[num1,den1] = zp2tf(z_1, p_1, k_1);
w = -10:0.1:10;

figure()
bp0 = bodeplot(sys_0,sys_1, '--',w, opts);
legend("Minimum Phase", "Mixed Phase", Location='Southwest')
[mag0,phase0,wout0] = bode(sys_0,w);
[mag1,phase1,wout1] = bode(sys_1,w);

phase0 = reshape(phase0,[],1);
phase1 = reshape(phase1,[],1);

figure()
hold on
phase_delay0 = -gradient(phase0, wout0);
plot(wout0, phase_delay0)

phase_delay1 = -gradient(phase1, wout1);
plot(wout1, phase_delay1,'--')
xlabel('Frequency (rad/s)')
ylabel('Phase Delay')
legend('Minimum Phase', 'Mixed Phase', Location='Northwest')
hold off