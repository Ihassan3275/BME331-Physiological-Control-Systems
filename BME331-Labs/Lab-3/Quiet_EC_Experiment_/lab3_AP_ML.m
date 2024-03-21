
format long
data = readmatrix('quiet_standing_ec.txt');

Fx = data(:, 1);
Fy = data(:, 2);
Fz = data(:, 3);
Mx = data(:, 1);
My = data(:, 2);
Mz = data(:, 3);
AP = zeros(24000,1);
ML = zeros(24000,1);

for i = 1:24000
    AP(i) = -(My(i) + Fx(i) * 0.0413)/Fz(i); % for AP
    ML(i) = (Mx(i) - Fy(i) * 0.0413)/Fz(i); % for ML
end

AP(17120:20560) = AP(1:3441); % Replace null items
ML(17120:20560) = ML(1:3441);
AP(20560:24000) = AP(10000:13440);
ML(20560:24000) = ML(10000:13440);

%[b, a] = butter(4, 5/480, 'low'); %the first parameter is the filter order, and the second parameter is the cutoff frequency divided by half the sampling frequency.
%Y = filtfilt(b, a, X); %x and y are your original and filtered signals, respectively, to be renamed as appropriate y = y – mean(y); %make the signal have zero-mean
%Y = Y - mean(Y);

% Calculate 8 variables
MDIST_AP = sum(abs(AP)) / 24000;
MDIST_ML = sum(abs(ML)) / 24000;

RDIST_AP = sqrt(sum(AP .^2) / 24000);
RDIST_ML = sqrt(sum(ML .^2) / 24000);

RANGE_AP = max(AP) - min(AP);
RANGE_ML = max(AP) - min(AP);

t = (0:24000-1) / 960; % 960 is the sampling frequency
T = t(end) - t(1);

MVELO_AP = sum(abs(diff(AP))) / T;
MVELO_ML = sum(abs(diff(ML))) / T;

colData = AP(:);
fileName = sprintf('AP_EC.txt');
writematrix(colData, fileName);


