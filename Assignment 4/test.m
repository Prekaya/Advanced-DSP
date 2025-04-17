% syms w
% N = 50;
% a = 0.5;
% wp = 0.1;
% ws = 0.125;
% n = 0:1:N/2;
% cw = cos(n*w)';
% 
% fs = (cw)*transpose(cw);
% fp = (1-cw)*transpose(1-cw);
% Rs_sym = int(fs,ws,pi);
% Rp_sym = int(fp,0,wp);
% 
% % test_R = double(a*Rp_sym + (1-a)*Rs_sym);
% M = 10
% k = 1:M;
% M+1-k
% N+1-k
    %     A(:,k) = x(:N+1-k)';
    % end 7

    % MATLAB program to demonstrate the full convolution
% Define two input signals
clc;
x = [2 4 6 8 5 6 7 6 7 9 8];	% Input signal
h = [0.7 0.7 0.7 0.7 1 1];	% Impulse response of a system “y = h”
% Perform full convolution
D = conv(x, h, 'full')';
C = conv(x, h, 'same')';
% Display the result
disp('Full Convolution of Signals x and h is:');
disp(D);
disp(C);