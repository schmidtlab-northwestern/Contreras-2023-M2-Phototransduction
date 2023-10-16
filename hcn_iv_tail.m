clear all; close all;

filename_control = 'filename.abf';
filename_zd = 'filename.abf';

[samples_control,period,f] = abfload(filename_control);
[samples_zd,period,f] = abfload(filename_zd);

fsamp = 1/(period/1000000); 

current_control = samples_control(:,1,:);
current_zd = samples_zd(:,1,:);

current_control = movmean(current_control, 1);
current_zd = movmean(current_zd, 1);

%% Voltage command plot 
voltage_step_trace = samples_control(:,2,:);

figure();
plot(voltage_step_trace(10000:50000,:),'k')

%% Plot zoomed out current trace for Control

current_controlfigure = current_control(1:80000,:);

figure_baseline_current_control = mean(current_controlfigure(1888:5056,:));

current_controlfigure = current_controlfigure - figure_baseline_current_control;

figure();
plot(current_controlfigure(10000:50000,:),'k');

%% Plot zoomed out current trace for ZD7288

current_zdfigure = current_zd(1:80000,:);

figure_baseline_current_zd = mean(current_zdfigure(1888:5056,:));

current_zdfigure = current_zdfigure - figure_baseline_current_zd;

figure();
plot(current_zdfigure(10000:50000,:),'r');

%% Plot zoomed out current trace for both Control and ZD7288

figure();
plot(current_controlfigure(10000:50000,:),'k');
hold on;
plot(current_zdfigure(10000:50000,:),'r');
hold off;

%% Control - ZD7288

current_diff = current_controlfigure(:,:)- current_zdfigure(:,:);

figure();
plot(current_diff(10000:50000,:),'b');

%% Measuring tail amplitude currents

current_tc_control = current_control(1:80000,:);
current_tc_zd = current_zd(1:80000,:);
current_tc_diff = current_diff(1:80000,:);

baseline_control = mean(current_tc_control(4045:10247,:));
baseline_zd = mean(current_tc_zd(4045:10247,:));
baseline_diff = mean(current_tc_diff(4045:10247,:));

peak_control = mean(current_tc_control(36395:49403,:));
peak_zd = mean(current_tc_zd(36395:49403,:));
peak_diff = mean(current_tc_diff(36395:49403,:));

tc_amplitude_control = baseline_control - peak_control 
tc_amplitude_zd = baseline_zd - peak_zd
tc_amplitude_diff = baseline_diff - peak_diff
