close all;
clear all;

filename = 'filename';
filename2 = strcat(filename,'.abf');

[samples,period,f] = abfload(filename2);

fsamp = 1/(period/1000000);

baseline_subtract = mean(samples(2500:2900,1));
new_samples = samples - baseline_subtract;

delta_I = mean(new_samples(1:900)); %calculate deltaI in pA
delta_V = 10; % 10mV voltage step

Rm = (delta_V/delta_I) * 1000; % convert to MOhms

cap_samples = new_samples(1087:3000,1);

area = trapz(cap_samples)/100;

capacitance = (area/10)*-1; % capacitance in pF

output = [Rm capacitance];
