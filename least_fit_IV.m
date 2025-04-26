clc; clear; close all;

% Given experimental data
V = [0.5; 1.0; 1.50; 2.0; 2.5; 3.0; 3.5; 4.0; 4.5; 5.0];  % Voltage (V)
I = [0.45; 1.15; 1.6; 2.1; 2.7; 2.9; 3.6; 4.3; 4.7; 5.1];  % Current (A)

% Initial guesses for resistance (R) and intercept (I0)
R_range = 0:0.01:10;   % Resistance range (ohms)
I0_range = -1:0.01:1;  % Intercept range

best_R = 0;
best_I0 = 0;
min_error = Inf; % Initialize with a high error

% Brute-force search for best R and I0
for i = 1:length(R_range)
    R = R_range(i);
    for j = 1:length(I0_range)
        I0 = I0_range(j);
        I_pred = (V / R) + I0; % Predicted current using Ohm's Law
        error = sum((I - I_pred).^2); % Sum of squared errors
        if error < min_error
            min_error = error;
            best_R = R;
            best_I0 = I0;
        end
    end
end

% Define extended range for plotting
V_extended = [0; V];
I_extended = (V_extended / best_R) + best_I0; % Compute corresponding I values

% Plot Experimental Data and Best Fit Line
figure;
scatter(V, I, 'bo'); hold on;
plot(V_extended, I_extended, 'r', 'LineWidth', 2);
xlabel('Voltage (V)');
ylabel('Current (A)');
title('Ohm''s Law: Best Fit Line using Least Squares');
legend('Experimental Data', 'Best Fit Line');
grid on;

% Display Final Best Fit Equation
printf('Best Fit Equation: I = (1/%.4f) * V + %.4f\n', best_R, best_I0);

% Adjust axes
ylim([min(I_extended)-1, max(I)+1]);
xlim([min(V_extended)-1, max(V)+1]);
