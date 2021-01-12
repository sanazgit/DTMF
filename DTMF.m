clear

[x,Fs]=audioread('DTMF1(2).wav');

T = 1/Fs;  
L=length(x);
t = (0:L-1)*T;               


Y= fft(x);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


f = Fs*(0:(L/2))/L;


%*******With hanning

x=x .* hanning(L);

Y2=fft(x);
Pa = abs(Y2/L);
Pb = Pa(1:L/2+1);
Pb(2:end-1) = 2*Pb(2:end-1);


subplot(1,2,1), plot(f,P1),title('DTMF_ WH'),xlabel('f (Hz)'),ylabel('|P1(f)|');hold on
subplot(1,2,2), plot(f,Pb),title('DTMF_ H'),xlabel('f (Hz)'),ylabel('|Pb(f)|');hold off


%****************************************************************

Fsn=8000;
L=0.5;

x1 = 4*sin(2*pi*800*t);          % First row wave
x2 = 6*sin(2*pi*1500*t);         % Second row wave
x3 = 8*sin(2*pi*2300*t);         % Third row wave

A = [4 6 8];

A= A / max(abs(A));

x1 = A(1,1)*sin(2*pi*800*t);          
x2 = A(1,2)*sin(2*pi*1500*t);        
x3 = A(1,3)*sin(2*pi*2300*t);   

S= x1+x2+x3;

filename = 'Multi-Frequency.wav';
audiowrite(filename,S,Fsn);

[S,Fsn] = audioread(filename);
sound(S,Fs);



