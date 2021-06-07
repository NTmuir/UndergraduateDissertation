%% MATLAB FFT Analysis
close all
clear
clc


A_1 = 6.75E-04;
w_1 = 265.06;
% A_2 = 0.000043365;
% w_2 = 1036.7;
% A_3 = 8.1147E-06;
% w_3 = 1061.2;
% A_4 = 6.3053E-06;
% w_4 = 2126.7;
% A_5 = 5.6582E-06;
% w_5 = 1959.8;



Fs = 1014;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 3000;             % Length of signal
t = (0:L-1)*T;        % Time vector

X = A_1 * sin(2*pi*w_1*t) %+ A_2 * sin(2*pi*w_2*t)+ A_3 * sin(2*pi*w_3*t)+ A_4 * sin(2*pi*w_4*t)+ A_5 * sin(2*pi*w_5*t);

figure
plot(1000*t(1:100),X(1:100))
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

syms t
a = 0.125*int(X,t,0,Fs);
Int = abs(sum(a));
disp(round(Int,5))
figure
plot(f,P1) 
set(gca, 'YScale', 'log')
title('FFT analysis from EDM ANSYS model')
xlim([0 500])
xlabel('f (Hz)')
ylabel('|x(f)|')
