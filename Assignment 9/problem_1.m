clc; clearvars;

WienerData = readtable("Wiener_Data.txt");
t=WienerData.Var1; y=WienerData.Var2; x1=WienerData.Var3; x2=WienerData.Var4;

prime_chan = y; ref_chan = [x1,x2];

scaled_t = (t - mean(t))/60;
n = 151; nref = size(ref_chan,2);
fs = 1/(t(2)-t(1));
all_cpsd = cpsd([prime_chan,ref_chan], ref_chan, kaiser(n),[],n,fs,"mimo")*fs;
Syx = all_cpsd(:,1,:);
Sxx = all_cpsd(:,2:end,:);

% Turn so w vectors are into the screen
Syx = permute(Syx,[3,2,1]); 
Sxx = permute(Sxx,[3,2,1]);

H = pagemldivide(Sxx,Syx); 
H = permute(H,[1,3,2]);

H = [H,conj(flip(H(:,2:end),2))];
h = ifft(H,[],2);
h = fftshift(h,2);



%% make filter and apply
filter = 0;
for i = 1:nref
    filter = filter + conv(ref_chan(:,i),h(i,:),"same");
end
filter_data = prime_chan - filter;


%% Plot filters 
figure()
tiledlayout
xt = (1:length(h(1,:)))/60;
for i = 1:nref
    nexttile
    plot(xt,h(i,:)); title(sprintf("Filter %d",i));
end

%% Plot filtered data
N = 2^13;

[pxx,f] = periodogram(filter_data,[],N,fs,"power");
pxx = 10*log10(pxx/max(pxx));

figure;
tiledlayout;
nexttile;
plot(scaled_t,filter_data); title('Primary channel time series');
xlabel("minutes"); xlim("tight");

nexttile
plot(f,pxx); title('Primary channel spectrum');
xlabel("Hz"); xlim([0, 0.1]);
ylabel("dB"); ylim([-30, 0]);