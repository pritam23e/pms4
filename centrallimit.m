clc; clear; close all;
%% Parameters
mu = 67;
sigma = 4.7;
n = 10000;
t = 1000;
s_values = 3:5:500;  % Sample sizes
num_s = length(s_values);
std_means = zeros(num_s, 1);  % Store std dev of sample means

%% Generate population data
data = mu + sigma * randn(n, 1);

%% Sampling loop
for idx = 1:num_s
    s = s_values(idx);
    sample_means = zeros(t, 1);
    for i = 1:t
        indices = randi(n, s, 1);
        sample = data(indices);
        sample_means(i) = mean(sample);
    end
    std_means(idx) = std(sample_means);
end
m = mean(sample_means);

%% Plot 1: Std Dev vs s
figure;
subplot(1, 2, 1);
plot(s_values, std_means, 'bo-', 'LineWidth', 2);
xlabel('Sample Size (s)');
ylabel('Std Dev of Sample Means');
title('Std Dev vs Sample Size');
grid on;

%% Plot 2: Std Dev vs 1/sqrt(s)
inv_root_s = 1 ./ sqrt(s_values);
subplot(1, 2, 2);
plot(inv_root_s, std_means, 'ro-', 'LineWidth', 2);
xlabel('1 / sqrt(s)');
ylabel('Std Dev of Sample Means');
title('Std Dev vs 1/sqrt(s)');
grid on;

%% Linear fit and slope for second plot
coeffs = polyfit(inv_root_s, std_means', 1);  % Fit line: y = m*x + b
slope = coeffs(1);
intercept = coeffs(2);
printf('Slope of Std Dev vs 1/sqrt(s): %.4f\n', slope);
printf('Intercept: %.4f\n', intercept);
printf('Original Standard Deviation: %.4f\n', slope);
printf('Original Mean: %.4f\n', m);

% Optional: Plot the fitted line
hold on;
x_fit = linspace(min(inv_root_s), max(inv_root_s), 100);
y_fit = polyval(coeffs, x_fit);
plot(x_fit, y_fit, 'k--', 'LineWidth', 1.5);
legend('Data', sprintf('Fit: y = %.2fx + %.2f', slope, intercept));
