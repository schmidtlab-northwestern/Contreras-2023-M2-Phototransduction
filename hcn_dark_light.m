clear all; close all;

filename_dark = 'filename.abf';
filename_light = 'filename.abf';

[samples_dark,period,f] = abfload(filename_dark);
[samples_light,period,f] = abfload(filename_light);

fsamp = 1/(period/1000000); 

current_dark = samples_dark(:,1);
current_light = samples_light(:,1);

current_dark = movmean(current_dark, 1);
current_light = movmean(current_light, 1);

voltage_step_trace = samples_dark(:,2);

%% Plot zoomed out current traces (dark vs. light) 

figure();
plot(current_dark(18000:180000),'k');
hold on;
plot(current_light(18000:180000),'b');
hold off;



%% Plot seal tests on top of each other (dark vs.light)

sealtest_start = 12914;
sealtest_end = 13684;

current_sealtest_dark = current_dark(sealtest_start:sealtest_end);
baseline_dark = mean(current_sealtest_dark(1:150));

current_sealtest_dark = current_sealtest_dark - baseline_dark;

current_sealtest_light = current_light(sealtest_start:sealtest_end);
baseline_light = mean(current_sealtest_light(1:150));

current_sealtest_light = current_sealtest_light - baseline_light;

figure();
plot(current_sealtest_dark, 'k');
hold on;
plot(current_sealtest_light, 'b');
hold off;

%% Tail current 

tc_start = 73467;
tc_end = 82545;

current_tc_dark = current_dark(73467:84012);
current_tc_light = current_light(73467:84012);

baseline_dark = mean(current_tc_dark(8000:10000));
baseline_light = mean(current_tc_light(8000:10000));

peak_dark = min(current_tc_dark);
peak_light = min(current_tc_light);

tc_amplitude_dark = baseline_dark - peak_dark
tc_amplitude_light = baseline_light - peak_light

current_tc_dark = current_tc_dark - baseline_dark;
current_tc_light = current_tc_light - baseline_light;

figure();
plot(current_tc_dark, 'k');
hold on;
plot(current_tc_light, 'b');
hold off;

%% Inward HCN current 
hc_start = 34040;
hc_end = 73295;

current_hc_dark = current_dark(34040:73295);
current_hc_light = current_light(34040:73295);

baseline_dark = mean(current_tc_dark(8000:10000));
baseline_light = mean(current_tc_light(8000:10000));

hc_dark = min(current_hc_dark);
hc_light = min(current_hc_light);

hc_amplitude_dark = baseline_dark - hc_dark
hc_amplitude_light = baseline_light - hc_light

%% Isolating the Ihold
figure();

ihold_dark = mean(current_dark(18000:28545))
ihold_light = mean(current_light(18000:28545))
ihold_delta = ihold_dark - ihold_light

plot(current_dark(18000:28545),'k');
hold on;
plot(current_light(18000:28545),'b');
hold off;

%% Figure for looking at whole trace 

current_darkfigure = current_dark(18000:180000);
current_lightfigure = current_light(18000:180000);

figure_baseline_dark = mean(current_darkfigure(1:10000));
figure_baseline_light = mean(current_lightfigure(1:10000));

current_darkfigure = current_darkfigure - figure_baseline_dark;
current_lightfigure = current_lightfigure - figure_baseline_light;

figure();
plot(current_darkfigure,'k');
hold on;
plot(current_lightfigure,'b');
hold off;

figure();
plot(voltage_step_trace(18000:180000));