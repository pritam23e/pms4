%BernoulliProof for GNU Octave (fully compatible)
clc; clear; close all;

% Parameters
num_tosses = 100; % Number of coin tosses per experiment
p = 0.5; % Probability of getting heads
experiment_counts = [10, 100, 1000, 10000]; % Different numbers of experiments

% Define sky blue color
sky_blue = [0.529, 0.808, 0.922];

% Prepare figure
figure;


% Function to compute log of binomial coefficient
log_nchoosek = @(n, k) gammaln(n + 1) - gammaln(k + 1) - gammaln(n - k + 1);

% Loop over different numbers of experiments
for idx = 1:length(experiment_counts)
    num_experiments = experiment_counts(idx);

    % Simulate multiple experiments
    heads_count = sum(rand(num_experiments, num_tosses) < p, 2);

    % Probability calculation using log to prevent overflow
    k_values = 0:num_tosses; % Possible head counts
    log_P_k = log_nchoosek(num_tosses, k_values) + k_values * log(p) + (num_tosses - k_values) * log(1 - p);
    P_k = exp(log_P_k); % Convert back to normal scale

    % Smooth interpolation for Binomial curve
    x_interp = linspace(0, num_tosses, 300); % More points for smoothness
    P_interp = interp1(k_values, P_k, x_interp, "spline");

    % Create subplot
    subplot(2,2,idx);

    % Plot histogram manually
    nbins = 30; % number of bins for histogram
    [counts, centers] = hist(heads_count, nbins);
    bar(centers, counts / trapz(centers, counts), 1, 'FaceColor', 'b', 'EdgeColor', 'none');
    hold on;

    % Overlay Binomial probability as a smooth curve
    plot(x_interp, P_interp, 'r', 'LineWidth', 2);

    % Set x-axis limits
    xlim([0 num_tosses]);

    % Labels and title
    xlabel('Number of Heads');
    ylabel('Probability Density');
    title(sprintf('%d Experiments', num_experiments));
    legend('Simulated Distribution', 'Binomial Probability Curve', 'Location', 'northwest');
    grid on;
    hold off;
end

% Overall title
if exist('suptitle', 'file')
    suptitle('Binomial Distribution Convergence with Increasing Experiments');
else
    annotation('textbox', [0 0.95 1 0.05], 'String', 'Binomial Distribution Convergence with Increasing Experiments', ...
        'EdgeColor', 'none', 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 12);
end
