freq_range = 0.005*pi:0.005*pi:pi;
sample_time = 0.1;
outputs_hr_mag = zeros(1, length(freq_range));
outputs_abp_mag = zeros(1, length(freq_range));

for i = 1:length(freq_range)
    freq = freq_range(i);
    sim('rsa');
    outputs_hr_mag(i) = max(hr);
    outputs_abp_mag(i) = max(abp);    
end;

figure
plot(freq_range, outputs_hr_mag);
xlabel('Frequency (Hz)');
ylabel('Magnitude (bpm L-1)');
figure
plot(freq_range, outputs_abp_mag);
xlabel('Frequency (Hz)');
ylabel('Magnitude (mm Hg L-1)');
