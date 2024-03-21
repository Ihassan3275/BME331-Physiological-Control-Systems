Fs = 10;
t = 0:1/Fs:300;
N = length(V);


%Compute and plot frequency response of hr
[Pv, Frequencies] = pwelch(V,hanning(N),0,N,Fs);
Pvhr = cpsd(hr, V, hanning(N), 0, N, Fs');   %cross-spectrum of hr and V
Hvhr = Pvhr./(Pv);

Hvhrmag = abs(Hvhr);
Hvhrphase = angle(Hvhr)*180/pi;

figure
subplot(2,1,1);
plot(Frequencies, abs(Hvhr));
xlabel('Frequency (Hz)');
ylabel('Magnitude (bpm L-1)');
subplot(2,1,2);
plot(Frequencies, angle(Hvhr)*180/pi);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');

%Compute and plot frequency response of abp
Pvabp = cpsd(abp, V, hanning(N), 0, N, Fs');   %cross-spectrum of abp and V
Hvabp = Pvabp./(Pv);

Hvabpmag = abs(Hvabp);
Hvabpphase = angle(Hvabp)*180/pi;

figure
subplot(2,1,1);
plot(Frequencies, abs(Hvabp));
xlabel('Frequency (Hz)');
ylabel('Magnitude (mm Hg L-1)');
subplot(2,1,2);
plot(Frequencies, angle(Hvabp)*180/pi);
xlabel('Frequency (Hz)');
ylabel('Phase (deg)');