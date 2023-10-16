clear all; close all;

filename_control = 'filename.abf';
filename_zd = 'filename.abf';

[samples_control,period,f] = abfload(filename_control);
[samples_zd,period,f] = abfload(filename_zd);

fsamp = 1/(period/1000000); 

current_control = samples_control(:,1);
current_zd = samples_zd(:,1);

current_control = movmean(current_control, 1);
current_zd = movmean(current_zd, 1);

voltage_step_trace = samples_control(:,2);

%% Plot zoomed out current traces (control vs. zd) 

figure();
plot(current_control(18000:180000),'k');
hold on;
plot(current_zd(18000:180000),'r');
hold off;

%% Figure for looking at whole trace 

current_controlfigure = current_control(18000:180000);
current_zdfigure = current_zd(18000:180000);

figure_baseline_control = mean(current_controlfigure(1:10000));
figure_baseline_zd = mean(current_zdfigure(1:10000));

current_controlfigure = current_controlfigure - figure_baseline_control;
current_zdfigure = current_zdfigure - figure_baseline_zd;

figure();
plot(current_controlfigure,'k');
hold on;
plot(current_zdfigure,'r');
hold off;

figure();
plot(voltage_step_trace(18000:180000));

%% Plot seal tests on top of each other (dark vs.zd)

sealtest_start = 12914;
sealtest_end = 13684;

current_sealtest_control = current_control(sealtest_start:sealtest_end);
baseline_control = mean(current_sealtest_control(1:150));

current_sealtest_contol = current_sealtest_control - baseline_control;

current_sealtest_zd = current_zd(sealtest_start:sealtest_end);
baseline_zd = mean(current_sealtest_zd(1:150));

current_sealtest_zd = current_sealtest_zd - baseline_zd;

figure();
plot(current_sealtest_control, 'k');
hold on;
plot(current_sealtest_zd, 'r');
hold off;

%% Tail current 

tc_start = 73467;
tc_end = 82545;

current_tc_control = current_control(73467:84012);
current_tc_zd = current_zd(73467:84012);

baseline_control = mean(current_tc_control(8000:10000));
baseline_zd = mean(current_tc_zd(8000:10000));

peak_control = min(current_tc_control);
peak_zd = min(current_tc_zd);

tc_amplitude_control = baseline_control - peak_control
tc_amplitude_zd = baseline_zd - peak_zd

current_tc_control = current_tc_control - baseline_control;
current_tc_zd = current_tc_zd - baseline_zd;

figure();
plot(current_tc_control, 'k');
hold on;
plot(current_tc_zd, 'r');
hold off;
