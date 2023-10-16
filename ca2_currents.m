clear all; close all;

filename_control = 'filename.abf';
filename_ttap2 = 'filename.abf';

[samples_control,period,f] = abfload(filename_control);
[samples_ttap2,period,f] = abfload(filename_ttap2);

fsamp = 1/(period/1000000); 

current_control = samples_control(:,1,:);
current_ttap2 = samples_ttap2(:,1,:);

current_control = movmean(current_control, 1);
current_ttap2 = movmean(current_ttap2, 1);

%% Voltage command plot 

voltage_step_trace = samples_control(:,2,:);

figure();
plot(voltage_step_trace(:,:),'m')

%% Plot zoomed out current trace for Control
% It's in dimension 1 with current 

current_controlfigure = current_control(1:5902,:);

figure_baseline_current_control = mean(current_controlfigure(3798:4025,:));

current_controlfigure = current_controlfigure - figure_baseline_current_control;

figure();
plot(current_controlfigure(2912:3903,:),'k');

%% Plot zoomed out current trace for TTA-P2

current_ttap2figure = current_ttap2(1:5902,:);

figure_baseline_current_ttap2 = mean(current_ttap2figure(3798:4025,:));

current_ttap2figure = current_ttap2figure - figure_baseline_current_ttap2;

figure();
plot(current_ttap2figure(2912:3903,:),'m');

%% Plot zoomed out current trace for both Control and TTA-P2

figure();
plot(current_controlfigure(2970:4000,:),'k'); 
hold on;
plot(current_ttap2figure(2970:4000,:),'m');
hold off;

%% Control - TTA-P2

current_diff = current_controlfigure(:,:)- current_ttap2figure(:,:);

figure();
plot(current_diff(2912:3903,:),'c');

%% Measuring Amplitude Currents

current_c_control = current_control(3011:5902,:);
current_c_ttap2 = current_ttap2(3011:5902,:);
current_c_diff = current_diff(3011:5902,:);

baseline_control = mean(current_c_control(5102:6000));
baseline_state_ttap2 = mean(current_c_ttap2(5102:6000));
steady_state_diff = mean(current_c_diff(5102:6000));

peak_control = min(current_c_control);
peak_ttap2 = min(current_c_ttap2);
peak_diff = min(current_c_diff);

amplitude_control = baseline_control - peak_control
amplitude_ttap2 = baseline_state_ttap2 - peak_ttap2 
amplitude_diff = steady_state_diff - peak_diff

