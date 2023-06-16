clc
close all;
clear;
Q = input(' what is your choice?\n 1 = voice proccesing\n 2 = signal function \n your choice is :  ');
switch Q
%% Time and input voice
case 1
 file = uigetfile({'*.m4a;*.mp3 ;*.wav'},'Select Your Voice');
 P=file;
 [x , fs] = audioread(file);
 Tf = audioinfo(file);
 Tf=Tf.Duration;
 A = size(x,1);
 x(A+1,:)=0;
 T0 = 0 ;
 t=T0:1/fs:Tf ;
 case 2
fs=10000;
t=-5:1/fs:5;
x = input(' Enter your function\n xa(t)= ');
end
if Q==1||Q==2
   M= input(' what is your sampling rate\n Fs =');
 %% Input voice
 figure(1)
 subplot(321);
 plot(t,x);
 title('Input Signal');
 xlabel('Time(s)');
 ylabel('xa(t)');
 grid on ;
 X = fftshift(fft(x)) ;
 N = numel(x) ;           
 f = fs/N*(-N/2:1:N/2-1);
 figure(1)
 subplot(322)
 plot( f,abs(X));
 title('Fourier Input Signal');
 xlabel('Frequency(Hz)');
 ylabel('|X(F)|');
 grid on;
 %% Power 
 S=(abs(X)).^2;
 normalize_S=S./max(S);
 N = numel(x) ;           
 f = fs/N*(-N/2:1:N/2-1);
 figure(2)
 plot( f,S,'color','black');
 title('Power Secturm Input Signal');
 xlabel('Frequency(Hz)');
 ylabel('|X(F)|^2');
 grid on;
 figure(2)
 %% Sampeling 1
 xa=zeros(size(x));
 for i=1:M:length(x)
    xa(i)=x(i);
 end
 figure(1)
 subplot(323);
 stem(t,xa,'color','r');
 title('Sampled Signal');
 xlabel('n');
 ylabel('x(n)');
 grid on ;
 Xa = fftshift(fft(xa)) ;
 N = numel(xa) ;           
 f = fs/N*(-N/2:1:N/2-1);
 figure(1)
 subplot(324)
 plot( f,abs(Xa),'color','r');
 title(' Fourier Sampled Signal');
 xlabel('Frequency(Hz)');
 ylabel('|X(F)|');
 grid on;

%% F3dB
switch Q
    case 1 
        [e,~]=find(normalize_S==1);
        for i=max(e):1:length(S)
            if S(i) <= 0.018
                break;
            end
        end
    case 2
        [~,w]=find(normalize_S==1);
        for i=max(w):1:length(S)
            if normalize_S(i) <= 10^(-4)
            break;
            end
        end
end
F3dB = f(i);
%%  Low pass filter and Reconstruction input Signal
z=filter(low_fil(fs,F3dB),xa);
 figure(1)
 subplot(325)
 plot( t,z,'color','cyan');
 title('Reconstruction input Signal');
 xlabel('Time(s)');
 ylabel('y(t)');
 grid on;
 Z = fftshift(fft(z)) ;
 N = numel(z) ;           
 f = fs/N*(-N/2:1:N/2-1);
 figure(1)
 subplot(326)
 plot( f,abs(Z),'color','cyan');
 title('Fourier Reconstruction input Signal');
 xlabel('Frequency(Hz)');
 ylabel('|Y(F)|');
 grid on;
%% Output and Amplifier
z=M*z;
 figure(3)
 subplot(211)
 plot(t,z);
 title('Out put Signal');
 xlabel('Time(s)');
 ylabel('xo(t)');
 grid on;
 Z = fftshift(fft(z)) ;
 N = numel(z) ;           
 f = fs/N*(-N/2:1:N/2-1);
 figure(3)
 subplot(212)
 plot( f,abs(Z));
 title('Fourier Out put Signal');
 xlabel('Frequency(Hz)');
 ylabel('|Xo(F)|');
 grid on;
 %% Gender and Reconstruction input voice
if Q==1
    [man , ~] = audioread(P);
    f0 = freq(man);
    b=mean(f0);
    if b>165
        fprintf("Female Voice\n");
    else
        fprintf('Male Voice\n');
    end
    audiowrite('Sampeling Reconstruction.wav',z,fs)
    disp('Output voice saved');
end
else  
disp('EROR');
end

 
 


 
  
 
 
