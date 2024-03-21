
load AP_EC.txt; %adapt these load commands to the file names that you use during your data collection 
load SOL_EC.txt;

freq = 960;
seg_length = 8192;
for k = 1:2
a = (k-1)*(seg_length)+ 4801;
b = (seg_length+4800) + (k-1)*(seg_length);
ccf = xcorr(SOL_EC(a:b) - mean(SOL_EC(a:b)), AP_EC(a:b) - mean(AP_EC(a:b)),'coeff'); ccf_seg(k,:) = ccf;
end
avg_ccf = mean(ccf_seg);
time = (-(seg_length-1):1:(seg_length-1))/freq; plot(time,avg_ccf);
%AP_EO: AP data for eyes open %SOL_EO: Soleus EMG data for eyes open %freq: sampling frequency
%seg_length: length of one segment
%k: number of segments
%a,b: boundaries for the segments
%ccf: ccf for one specific segment %ccf_seg: ccf for all segments
%avg_ccf: ensemble-averaged ccf
%time: time scale for avg_ccf
