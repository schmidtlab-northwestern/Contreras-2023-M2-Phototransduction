% This code plots the intrinsic photocurrent and calculates the maximum,
% early, intermediate, and late components. 

% This makes use of the abfload function created by Harald Hentschke 
% https://www.mathworks.com/matlabcentral/fileexchange/6190-abfload


clear all; close all;

%% Plotting 50ms light stimulation responses

filename_array = xlsread('Path_to_file'); %load data
filename_array = num2str(filename_array); 

ymin = -150;
ymax = 50;
trace_color = 'k';

%% Open abf files
number_of_traces = size(filename_array,1); 
current_array = [];

for x = 1:number_of_traces
    filename = filename_array(x,:);
try
[temp_samples,period,f] = abfload(filename);

catch    
    [temp_samples,period,f] = abfload([filename(1:6) '_' filename(7:end) '.abf']); 
end

temp_samples = transpose(temp_samples);
temp_samples = temp_samples(1,:);

temp_samples = movmean(temp_samples, 100);

temp_baseline = mean(temp_samples(1:40000)); 
baseline_subtracted = temp_samples - temp_baseline;

current_array = [current_array; baseline_subtracted];

end

fsamp = 1/(period/1000000); 

%% Loop that will be used to actually plot all the files on top of each other
figure(); hold on;

for y = 1:number_of_traces
    
    plot(current_array(y,:));
    
end

hold off;
ylim([ymin ymax]);

%% Average trace
average_current_array = mean(current_array);
std_current_array = std(current_array);
time = (1:length(average_current_array))/fsamp;

figure();

plot(average_current_array);

ylim([ymin ymax]);

%% Analysis  
%Maximum amplitude the greatest change from the baseline 

%Light ONSET: 5987.6 ms MEASUREMENTS ARE AFTER LIGHT ONSET
%Early (141.7-440.4 ms)
%Intermediate: (2857.7-6598.2 ms)
%Late (9062.3-14062.3 ms) 

peak_amp = [];
amplitude_early = [];
amplitude_int = [];
amplitude_late = [];

for p = 1:number_of_traces
    
    temp_array =  current_array(p,:);
    temp_early = mean(temp_array(61293:64280));
    temp_int = mean(temp_array(88453:125862));
    temp_late = mean(temp_array(150000:200000));
    
    
    amplitude_early = [amplitude_early; temp_early];
    amplitude_int = [amplitude_int; temp_int];
    amplitude_late = [amplitude_late; temp_late];
    
    
    temp_baseline = mean(temp_array(16303:36649));
    temp_trace = min(temp_array(59876:600000));
 
    temp_peak = temp_baseline - temp_trace;
    peak_amp = [peak_amp; temp_peak];

end

