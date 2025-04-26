%Gaussian
clear all
close all

% Define n (the number of classes)
n = 100; % Change this value as needed

% Generate x-axis values (number classes from 0 to n)
x = 1:n;

% Define the mean and standard deviation for the Gaussian distribution
mu = n / 2;         % Center the peak at the middle of the range
sigma = n / 6;      % Adjust sigma to control the spread

% Compute the Gaussian frequency values
y = exp(-((x - mu).^2) / (2 * sigma^2));

% Normalize y to make it resemble a frequency distribution
y = y / max(y) * 100; % Scale to a reasonable range

% Compute statistical measures
mean_value = sum(x .* y) / sum(y); % Weighted mean
median_value = median(x); % Median of the x values
[~, mode_index] = max(y); % Mode is the x-value with highest frequency
mode_value = x(mode_index);

% Compute standard deviation (weighted)
std_dev = sqrt(sum(((x - mean_value).^2) .* y) / sum(y));

% Plot the bar graph
b = bar(x, y, 'c'); % 'c' for cyan bars
set(b, 'EdgeColor', 'none'); % Removes the border (Octave compatible)

hold on;

% Mark mean, median, mode, and ±1 standard deviation
y_limits = [0, max(y)]; % Get the range for y-axis

% Vertical lines for mean, median, mode
plot([mean_value mean_value], y_limits, 'r--', 'LineWidth', 2); % Mean (Red Dashed)
plot([median_value median_value], y_limits, 'g:', 'LineWidth', 2); % Median (Green Dotted)
plot([mode_value mode_value], y_limits, 'k-.', 'LineWidth', 2); % Mode (Black Dash-Dot)

% ±1 Standard deviation from the mean
plot([mean_value - std_dev, mean_value - std_dev], y_limits, 'm--', 'LineWidth', 1.5); % -1σ (Magenta Dashed)
plot([mean_value + std_dev, mean_value + std_dev], y_limits, 'm--', 'LineWidth', 1.5); % +1σ (Magenta Dashed)

% Labels and title
xlabel('Number Class');
ylabel('Frequency');
title('Gaussian Bell-Shaped Distribution with Mean, Median, Mode, and Std Dev');

% Legend
legend('Distribution', 'Mean (Red Dashed)', 'Median (Green Dotted)', ...
       'Mode (Black Dash-Dot)', '±1 Std Dev (Magenta)', 'Location', 'Best');

% Grid for better visualization
grid on;
hold off;

% Display statistical values
fprintf('Mean: %.2f\n', mean_value);
fprintf('Median: %.2f\n', median_value);
fprintf('Mode: %.2f\n', mode_value);
fprintf('Standard Deviation: %.2f\n', std_dev);
