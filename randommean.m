% Random chart generation compatible with GNU Octave
clear all;
close all;

% Set the range of integers
n = 20; % From 1 to 20

% Generate random frequencies for each integer from 1 to 20
max_frequency = 100;
frequencies = randi([1, max_frequency], 1, n);

% Calculate Mean
mean_freq = sum((1:n) .* frequencies) / sum(frequencies);

% Calculate Standard Deviation (weighted)
mean_diff_sq = ((1:n) - mean_freq).^2;
std_dev = sqrt(sum(mean_diff_sq .* frequencies) / sum(frequencies));

% Calculate Median using Cumulative Frequency
cumulative_freq = cumsum(frequencies);
total_freq = sum(frequencies);
median_index = find(cumulative_freq >= total_freq / 2, 1);
median_freq = median_index;

% Calculate Mode
[~, mode_index] = max(frequencies);
mode_freq = mode_index;

% Display the calculated statistics
fprintf('Mean of Frequencies: %.2f\n', mean_freq);
fprintf('Median of Frequencies: %d\n', median_freq);
fprintf('Mode of Frequencies: %d\n', mode_freq);
fprintf('Standard Deviation: %.2f\n', std_dev);

% Plotting the Frequencies
figure;
b = bar(1:n, frequencies, 'c');
set(b, 'EdgeColor', 'none');
title('Random Frequencies for Integer Values from 1 to 20');
xlabel('Integer Values');
ylabel('Frequencies');
xticks(1:n);
grid on;

% Add vertical lines for Mean, Median, Mode, and ±1 Std Dev
hold on;
y_limits = ylim();

% Mean line
plot([mean_freq mean_freq], y_limits, 'r--', 'LineWidth', 2);
text(mean_freq, y_limits(2)*0.95, sprintf('Mean: %.2f', mean_freq), 'Color', 'r', 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

% Median line
plot([median_freq median_freq], y_limits, 'g--', 'LineWidth', 2);
text(median_freq, y_limits(2)*0.90, sprintf('Median: %d', median_freq), 'Color', 'g', 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

% Mode line
plot([mode_freq mode_freq], y_limits, 'b--', 'LineWidth', 2);
text(mode_freq, y_limits(2)*0.85, sprintf('Mode: %d', mode_freq), 'Color', 'b', 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

% ±1 Standard Deviation lines
plot([mean_freq + std_dev, mean_freq + std_dev], y_limits, 'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 2);
plot([mean_freq - std_dev, mean_freq - std_dev], y_limits, 'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 2);
text(mean_freq + std_dev, y_limits(2)*0.80, sprintf('+1σ: %.2f', mean_freq + std_dev), 'Color', [1 0.5 0], 'FontWeight', 'bold', 'HorizontalAlignment', 'left');
text(mean_freq - std_dev, y_limits(2)*0.75, sprintf('-1σ: %.2f', mean_freq - std_dev), 'Color', [1 0.5 0], 'FontWeight', 'bold', 'HorizontalAlignment', 'left');

hold off;
legend('Frequencies', 'Mean', 'Median', 'Mode', '+1 Std Dev', '-1 Std Dev', 'Location', 'northeast');
