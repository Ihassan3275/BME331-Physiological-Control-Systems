%Step 0: extract ECG segments to work with (here taking 1 minute of the filtered data and discarding first 5 seconds)
baseline_ecg = baseECG(3000:36000, 4);
slow_ecg = slowECG(3000:36000, 4);
fast_ecg = fastECG(3000:36000, 4);

%Step 1a: find each heartbeat in the ECG recordings, based on the R peak in the QRS complex.
%You may need to tweak the parameters of the findpeaks function to improve
%its performance on your recordings.  There should be one peak detected per
%heartbeat. Type "doc findpeaks" into the Matlab command window for more
%information.
[baseline_pks baseline_loc] = findpeaks(baseline_ecg, 'minpeakheight', 200,'minpeakdistance', 200);
[slow_pks slow_loc] = findpeaks(slow_ecg, 'minpeakheight', 200,'minpeakdistance', 200);
[fast_pks fast_loc] = findpeaks(fast_ecg, 'minpeakheight', 200,'minpeakdistance', 200);

%Step 1b: Plot results of heartbeat detection
peaks = zeros(length(baseline_ecg),1);
peaks(baseline_loc) = 200;
t = 5+(0:length(baseline_ecg)-1)/600;
figure; plot(t, baseline_ecg); hold; stem(t,peaks, 'r');
title('Baseline ECG heartbeats');
xlabel('time (s)');
ylabel('Amplitude (uV)');
peaks = zeros(length(slow_ecg),1);
peaks(slow_loc) = 200;
t = 5+(0:length(slow_ecg)-1)/600;
figure; plot(t, slow_ecg); hold; stem(t,peaks, 'r');
title('Slow ECG heartbeats');
xlabel('time (s)');
ylabel('Amplitude (uV)');
peaks = zeros(length(fast_ecg),1);
peaks(fast_loc) = 200;
t = 5+(0:length(fast_ecg)-1)/600;
figure; plot(t, fast_ecg); hold; stem(t, peaks, 'r');
title('Fast ECG heartbeats');
xlabel('time (s)');
ylabel('Amplitude (uV)');


%Step 2: Compute inter-beat intervals
ibi_baseline = baseline_loc(2:end) - baseline_loc(1:end-1);
ibi_slow = slow_loc(2:end) - slow_loc(1:end-1);
ibi_fast = fast_loc(2:end) - fast_loc(1:end-1);

%Step 3: Compute and plot instantaneous heart rate (recall that sampling rate is 600 Hz, and we want the results in beats per minute rather than beats per second.)
heart_rate_baseline = 60*600./ibi_baseline;
heart_rate_slow = 60*600./ibi_slow;
heart_rate_fast = 60*600./ibi_fast;

figure; plot(heart_rate_baseline); hold; plot(heart_rate_slow,'r'); plot(heart_rate_fast,'g');
title('Heart rate');
legend({'Baseline', 'Slow', 'Fast'});
xlabel('Heart beat');
ylabel('Instantaneous heart rate (bpm)');

%Step 4: Use standard deviation to evaluate variability in the three heart
%rates.

display(['Standard deviation of baseline heart rate: ' num2str(std(heart_rate_baseline))]);
display(['Standard deviation of slow heart rate: ' num2str(std(heart_rate_slow))]);
display(['Standard deviation of fast heart rate: ' num2str(std(heart_rate_fast))]);
