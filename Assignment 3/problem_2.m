clearvars; clc; 
xlims = [-pi pi];
opts = bodeoptions;
opts.FreqScale = 'linear';
opts.MagVisible = 'off';
opts.PhaseMatching = 'on';
opts.PhaseMatchingFreq = 1; 
opts.PhaseMatchingValue = 0;
opts.XLim = xlims;
z_0 = 0.75*exp(0.2i*pi);
p_0 = 0.5*exp(0.3i*pi);
k_0 = 1.0;

z_1 = 1 + 1i;
p_1 = -0.5 + 2i;
k_1 = 1.0;
ts = 0.1;
sys_0 =  zpk(z_0, p_0, k_0);
sys_1 =  zpk(z_1, p_1, k_1);

[num0,den0] = zp2tf(z_0, p_0, k_0);
[num1,den1] = zp2tf(z_1, p_1, k_1);
w = -pi:0.1:pi;

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
XTickLabel = {'-\pi','-\pi/2','0','\pi/2','\pi'};
legend('Minimum Phase', 'Mixed Phase', Location='Northwest')
set(gca,'XTick',-pi:pi/2:pi) 
set(gca,'XTickLabel',XTickLabel)
set(gca,'xlim',[-pi, pi])
hold off
