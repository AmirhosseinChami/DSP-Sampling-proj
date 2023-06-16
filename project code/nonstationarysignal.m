clear all;
close all;
clc;

%%creating non stationary signal
fs = 10;
t = 0:1/fs:100;
x = 2*t+t.*randn(size(t));
figure(1), subplot(211),
plot(t, x, 'r', 'LineWidth', 1);
grid on;
title('Non-stationary signal'), legend('signal');
xlabel('Time (s)'), ylabel('Amplitude');
%% fourier transform
xf = fftshift(fft(x));
N = numel(x) ;           
f = fs/N*(-N/2:1:N/2-1);
figure (1), subplot(212),
plot( f, abs(xf), 'b', 'LineWidth', 1);
grid on;
title('Non-stationary signal fourier transform'), legend('fourier transform');
xlabel('Frequency (Hz)'), ylabel('Magnitude');

%% windowing

for i=0:9
    xi=x(100*i+1:1:100*i+100);
    ti=t(100*i+1:1:100*i+100);
    figure(2), subplot(2,10,i+1),
    plot(ti,xi,'r');
    grid on;   
    xlabel('Time (s)'), ylabel('Amplitude');
    Xf = fftshift(fft(xi));
    N = numel(xi);           
    f = fs/N*(-N/2:1:N/2-1);
    figure (2), subplot(2,10,i+11),
    plot( f, abs(Xf), 'b');
    grid on;
    xlabel('Frequency (Hz)'), ylabel('Magnitude');
end