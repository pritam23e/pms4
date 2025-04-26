% Right skewed distribution
clear all;
close all;
clc;

n = 100; % Upper limit
x = 0:n; % X-axis values
t = 5/n;
y = round(10 * (x) .* exp(-t * (x))); % Right-skewed distribution

% Compute Mean
mean_val = sum(x .* y) / sum(y);

% Compute Median
cdf = cumsum(y) / sum(y); % Cumulative distribution
median_index = find(cdf >= 0.5, 1); % Find the first index where CDF ≥ 0.5
median_val = x(median_index);

% Compute Mode (Index with Maximum Frequency)
[~, mode_index] = max(y);
mode_val = x(mode_index);

% Compute Standard Deviation
mean_x = mean_val; % Already computed
std_dev = sqrt(sum(y .* (x - mean_x).^2) / sum(y));

% Plot Bar Graph
figure;
b = bar(x, y, 'c'); % Cyan bars
set(b, 'EdgeColor', 'none'); % Removes the border
hold on;

% Plot Mean, Median, Mode, and Standard Deviation as Vertical Lines
y_max = max(y); % To extend lines properly
plot([mean_val mean_val], [0 y_max], 'k--', 'LineWidth', 3); % Mean (Black Dashed)
plot([median_val median_val], [0 y_max], 'r-.', 'LineWidth', 3); % Median (Red Dash-Dot)
plot([mode_val mode_val], [0 y_max], 'b:', 'LineWidth', 3); % Mode (Blue Dotted)


% Plot Mean + Std and Mean - Std Lines
plot([mean_val + std_dev mean_val + std_dev], [0 y_max], 'm-', 'LineWidth', 2); % Mean + Std (Magenta Line)
plot([mean_val - std_dev mean_val - std_dev], [0 y_max], 'm-', 'LineWidth', 2); % Mean - Std (Magenta Line)

% Labels and Legend
xlabel('X-axis (Integer values)');
ylabel('Frequency');
title('Right-Skewed Bar Graph with Mean, Median, Mode, and Std Deviation');
legend({'Data', 'Mean', 'Median', 'Mode', 'Mean ± Std Dev'}, 'Location', 'northeast');
grid on;
hold off;

% Display Results
fprintf('Mean: %.2f\n', mean_val);
fprintf('Median: %.2f\n', median_val);
fprintf('Mode: %.2f\n', mode_val);
fprintf('Standard Deviation: %.2f\n', std_dev);
