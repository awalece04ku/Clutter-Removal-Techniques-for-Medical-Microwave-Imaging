%% Code to generate performance evaluation without main titles and XTickLabels
% This code is related to the "Clutter Removal Techniques for Medical
% Microwave Imaging" paper which is under review.
%Created by Dr Md Abdul Awal 
%Thanks to Co-Authors Dr Lei Guo and Dr kamel Sulatn for providing the data.  

%%
clear all
close all

% Data from the provided tables
metrics = {'PPRR', 'CM', 'ASR', 'TCSR', 'TEPR'};
algorithms = {'Diff Sub', 'Avg Sub', 'Adj Sub', 'Sym Sub', 'SVD-based', 'Spatial-Filter', ...
              'Entropy-Window', 'Entropy-Wiener', 'ICA-based', 'EMD-based','CEEMDAN-based'};

%  data for 5 tables

table1 = [
    0.34, 0.37, 0.39, 0.39, 0.28, 0.21, 0.58, 0.28, 4.80, 0.98, 0.293; % PPRR
    1, 0.55, 0.61, 0.60, 0.57, 0.60, 0.39, 0.47, 0.11, 0.37,0.004068; % CM
    -27.05, -13.60, -18.98, -18.86, -15.72, -14.57, -8.65, -16.53, 8.13, 0.06,-5.9996; % ASR
    -11.12, -10.06, -9.92, -9.8, -9.51, -9.26, -3.02, -11.63, 8.3, -0.07,1.3858; % TCSR
    0, 1.81, -0.24, -0.24, 0.83, 2.32, 11.05, -2.04, 11.13, 12.48,7.664; % TEPR
];


table2 = [
    0.32, 0.25, 0.37, 0.37, 0.27, 0.20, 0.55, 0.42, 2.98, 0.99,0.3345; % PPRR
    1, 0.55, 0.58, 0.58, 0.56, 0.59, 0.37, 0.39, 0.17, 0.36,0.0176; % CM
    -27.10, -13.13, -18.53, -18.41, -15.33, -14.11, -10.66, -9.25, 4.10, 0.0005,-5.1702; % ASR
    -8.72, -7.16, -6.91, -6.93, -7.15, -6.40, -3.73, -8.55, 2.49, -0.16,1.5198; % TCSR
    0, 2.08, -0.62, -0.86, 0.75, 2.52, 8.93, 2.73, 10.19, 10.92,6.5047; % TEPR
];

table3 = [
    0.40, 0.45, 0.48, 0.48, 0.22, 0.25, 0.58, 0.39, 6.13, 0.99, 0.2286; % PPRR
    1, 0.55, 0.61, 0.58, 0.55, 0.61, 0.51, 0.46, 0.12, 0.40,0.0196; % CM
    -24.72, -12.40, -17.43, -18.31, -16.01, -13.05, -8.98, -10.37, 9.52, -0.02,-9.8774; % ASR
    -12.05, -11.56, -11.21, -11.96, -11.22, -10.41, -1.64, -9.4, 7.18, 0.11,-1.6256; % TCSR
    0, 1.32, -0.48, -4.6, -1.33, 2.22, 9.53, 2.51, 11.84, 11.4,5.2014; % TEPR
];

table4 = [
    0.37, 0.42, 0.45, 0.45, 0.27, 0.23, 0.81, 0.41, 6.68, 0.99,0.3069; % PPRR
    1, 0.53, 0.56, 0.55, 0.54, 0.56, 0.47, 0.42, 0.13, 0.37,0.0036; % CM
    -26.19, -12.38, -16.61, -16.46, -15.91, -12.85, -5.10, -9.44, 11.24, -0.006,-7.9715; % ASR
    -11.07, -9.97, -8.65, -8.56, -10.03, -8.9, -7.60, -8.22, 10.46, 0.29,2.4679; % TCSR
    0, 1.7, -0.35, -2.88, -0.51, 2.45, 10.80, 3.46, 15.37, 12.0,6.9243; % TEPR
];

table5 = [
    0.21, 0.86, 1.49, 1.53, 0.52, 0.51, 0.73, 0.40, 3.83, 0.99,0.2769; % PPRR
    1, 0.37, 0.37, 0.34, 0.38, 0.37, 0.35, 0.40, 0.16, 0.35,0.0096; % CM
    -29.65, -2.33, 1.43, -0.80, -6.32, -1.32, -6.89, -9.42, 5.69, -0.022,-7.8856; % ASR
    -13.48, -1.15, 2.36, 1.13, -1.35, -0.26, -3.99, -4.03, 5.11, 0.15,-8.1039; % TCSR
    0, 14.56, 18.22, 14.45, 11.12, 15.56, 15.41, 9.29, 17.64, 16.20,8.3111; % TEPR
];

% Combine all tables
all_tables = {table1, table2, table3, table4, table5};

% Define a custom colormap with distinctly different colors
cmap = [
 0.00, 0.45, 0.74; % Blue
 0.85, 0.33, 0.10; % Red-Orange
 0.93, 0.69, 0.13; % Yellow
 0.49, 0.18, 0.56; % Purple
 0.47, 0.67, 0.19; % Green
 0.30, 0.75, 0.93; % Cyan
 0.64, 0.08, 0.18; % Dark Red
 0.98, 0.38, 0.58; % Pink
 0.79, 0.70, 0.84; % Lavender
 0.30, 0.30, 0.30; % Gray
 0.13, 0.55, 0.45; % Teal
];

% Create the figures and subplots for each metric
for i = 1:length(metrics)
    figure;
    metric = metrics{i};
    for j = 1:length(all_tables)
        subplot(1, 5, j);
        % Plot each bar with a different color
        b = bar(all_tables{j}(i, :), 'FaceColor', 'flat');
        % Assign colors from the custom colormap
        for k = 1:length(algorithms)
            b.CData(k, :) = cmap(k, :);
        end
        title(['Case ', num2str(j)]);
        xlabel('Algorithms');
        ylabel(metric);
        % Remove X tick labels as requested
        set(gca, 'XTickLabel', {});
    end
    % Remove the main sgtitle as requested
    % sgtitle(['Performance Metric: ', metric]); % Title for the entire figure is removed
end


%%
% Create the color legend figure
cmap = [
 0.00, 0.45, 0.74; % Blue
 0.85, 0.33, 0.10; % Red-Orange
 0.93, 0.69, 0.13; % Yellow
 0.49, 0.18, 0.56; % Purple
 0.47, 0.67, 0.19; % Green
 0.30, 0.75, 0.93; % Cyan
 0.64, 0.08, 0.18; % Dark Red
 0.98, 0.38, 0.58; % Pink
 0.79, 0.70, 0.84; % Lavender
 0.30, 0.30, 0.30; % Gray
 0.13, 0.55, 0.45; % Teal
];
% Corresponding labels for each color
labels = {'Diff Sub', 'Avg Sub', 'Adj Sub', 'Sym Sub', 'SVD-based', 'Spatial-Filter', ...
    'Entropy-Window', 'Entropy-Wiener', 'ICA-based', 'EMD-based','CEEMDAN-based'};

% Create a figure with increased size
figure('Position', [100, 100, 1200, 500]);

% Create individual bars instead of a single bar object
hold on;
for k = 1:length(cmap)
    h(k) = bar(k, 1, 'FaceColor', cmap(k,:));
end
hold off;

% Add a legend with the corresponding labels
lgd = legend(h, labels, 'Location', 'eastoutside');
% Adjust legend properties for better visibility
lgd.FontSize = 10;

% Set axis limits
ylim([0 1.2]);
xlim([0 11]);

% Remove the x-axis and y-axis ticks
set(gca, 'XTick', [], 'YTick', []);

% Remove the box around the plot
set(gca, 'box', 'off');

% Adjust figure to ensure legend is visible
set(gcf, 'Units', 'Normalized');
pos = get(gcf, 'Position');
pos(3) = pos(3) * 1.2; % Increase width by 20%
set(gcf, 'Position', pos);