%4. Generate 10000 normally distributed random numbers.
%Draw a histogram with 100 bins using those numbers.
%Find the mean, variance and average of the cubes of the data.
%Also find those using mean value of each bin and frequency count
%of each bin and compare those from previous result.

% Step 1: Generate 10,000 normally distributed random numbers
data =5000+1000* randn(10000, 1);  % Standard normal distribution

% Step 2: Plot histogram with 100 bins
num_bins = 100;
[counts, bin_edges] = hist(data, num_bins);
bar(bin_edges, counts);
title('Histogram of Normally Distributed Data');
xlabel('Value');
ylabel('Frequency');

% Step 3: Calculate statistics directly from data
mean_direct = mean(data);
variance_direct = var(data);
avg_cube_direct = mean(data.^3);

% Step 4: Approximate using histogram bins
% Find bin centers
bin_centers = bin_edges;

% Normalize frequencies (hist returns counts, not probabilities)
total_count = sum(counts);
probabilities = counts / total_count;

% Approximated mean, variance, and average cube using histogram
mean_hist = sum(bin_centers .* probabilities);
variance_hist = sum(((bin_centers - mean_hist).^2) .* probabilities);
avg_cube_hist = sum((bin_centers.^3) .* probabilities);

% Step 5: Display results
printf("\n--- Direct Calculation ---\n");
printf("Mean: %f\n", mean_direct);
printf("Variance: %f\n", variance_direct);
printf("Average of Cubes: %f\n", avg_cube_direct);
printf("\n--- Histogram-based Approximation ---\n");
printf("Mean: %f\n", mean_hist);
printf("Variance: %f\n", variance_hist);
printf("Average of Cubes: %f\n", avg_cube_hist);
